import os
import csv
from django.conf import settings
from django.utils import timezone
from django.core.mail import EmailMessage
from celery import shared_task

from core_o.models import Order  # adjust if needed


@shared_task(bind=True)
def email_agent(self):
    # Filter the pending orders
    orders = Order.objects.filter(status=Order.Status.PENDING).order_by('-created_at')

    if not orders.exists():
        return "No pending orders found."

    # Ensure pending_orders folder exists
    export_dir = os.path.join(settings.MEDIA_ROOT, "pending_orders")
    os.makedirs(export_dir, exist_ok=True)

    # Build filename with date + natural counter
    today_str = timezone.now().strftime("%Y-%m-%d")
    counter = 1
    while True:
        filename = f"{today_str}_{counter}.csv"
        export_path = os.path.join(export_dir, filename)
        if not os.path.exists(export_path):
            break
        counter += 1

    # Define CSV headers
    headers = [
        "order_reference_id", "customer_name", "Address", "delivery_city", "delivery_country", "customer_phone_number",
        "product_sku", "Quantity", "price", "shipping_charges", "Discount",
        "total_amount", "payment_mode"
    ]

    with open(export_path, "w", newline="", encoding="utf-8") as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(headers)

        for order in orders:
            address = order.addresses.filter(address_type="SHP").first() or order.addresses.first()

            for item in order.items.all():
                writer.writerow([
                    order.order_number,
                    address.fullName if address else "",
                    f"{address.line1}, {address.line2 if address.line2 else ''}" if address else "",
                    address.get_state_display() if address else "",
                    address.country if address else "",
                    address.phone if address else "",
                    item.product_SKU,
                    item.quantity,
                    round(item.total_price),
                    round(order.shipping_amount),
                    round(item.discount_amount),
                    round(item.total_price - item.discount_amount if item.discount_amount else item.total_price),
                    "COD",
                ])

            # ✅ update each order’s status to PROCESSING
            order.status = Order.Status.PROCESSING
            order.save(update_fields=["status"])

    # 📧 Send email with the CSV file attached
    email = EmailMessage(
        subject="Pending Orders Export",
        body="Attached is the latest pending orders CSV export.",
        from_email=settings.DEFAULT_FROM_EMAIL,
        to=["doorbix3@gmail.com"],
    )
    email.attach_file(export_path)
    email.send()

    return f"CSV exported and emailed to doorbix3@gmail.com ({export_path})"
