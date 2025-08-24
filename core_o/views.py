from decimal import Decimal
from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from django.db.models import Prefetch
from rest_framework.permissions import AllowAny, IsAuthenticatedOrReadOnly
from .models import Order, OrderItem, OrderAddress
from .serializers import OrderSerializer
from django.core.mail import send_mail
from django.conf import settings
from django.utils import timezone
from django.template.loader import render_to_string
from django.core.mail import EmailMultiAlternatives

class OrderPlacer(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        serializer = OrderSerializer(data=request.data, context={"request": request})
        
        if serializer.is_valid():
            order = serializer.save()

            # =============================
            #  APPLY DISCOUNT FOR AUTH USERS
            # =============================
            if order.user and order.user.is_authenticated:
                discount_percent = getattr(settings, "SUBSCRIBED_USER_DISCOUNT", 0)

                try:
                    discount_percent = int(discount_percent)  # ensure integer
                except ValueError:
                    discount_percent = 0

                if discount_percent > 0:
                    # discount = (subtotal * discount%) / 100
                    discount_value = (order.subtotal_amount * Decimal(discount_percent)) / Decimal(100)

                    # Ensure it’s rounded to 2 decimals (since DecimalField has 2 decimal places)
                    discount_value = discount_value.quantize(Decimal("0.01"))

                    order.discount_amount = discount_value
                    order.total_amount = (order.subtotal_amount + order.shipping_amount + order.tax_amount) - discount_value
                    order.save(update_fields=["discount_amount", "total_amount"])

            # =============================
            #   EMAIL SENDING
            # =============================
            recipient_emails = list(
                set(
                    addr.email.strip()
                    for addr in order.addresses.all()
                    if addr.email
                )
            )

            if recipient_emails:
                try:
                    context = {
                        "user": {"name": order.user.first_name if order.user else "Guest"},
                        "order": {
                            "order_number": order.order_number,
                            "id": order.id,
                            "subtotal": order.subtotal_amount,
                            "shipping": order.shipping_amount,
                            "discount": order.discount_amount,
                            "total": order.total_amount,
                            "currency": order.currency,
                            "items": [
                                {
                                    "name": item.name,
                                    "quantity": item.quantity,
                                    "price": item.total_price,
                                }
                                for item in order.items.all()
                            ],
                            "tracking_url": f"https://doorbix.com/orders/{order.id}/track/",
                        },
                        "current_year": timezone.now().year,
                    }

                    html_content = render_to_string("email/order.html", context)
                    text_content = f"Thank you for your order {order.order_number}. Total: {order.total_amount} {order.currency}"

                    email = EmailMultiAlternatives(
                        subject=f"Your Order Confirmation: {order.order_number}",
                        body=text_content,
                        from_email=settings.DEFAULT_FROM_EMAIL,
                        to=recipient_emails,
                    )
                    email.attach_alternative(html_content, "text/html")
                    email.send(fail_silently=False)

                except Exception as e:
                    print(f"⚠ Email sending failed for order {order.id}: {e}")
            else:
                print(f"Order {order.order_number} placed successfully (⚠ no email found)")

            return Response(
                {
                    "message": "Order placed successfully!",
                    "order_id": order.id,
                    "emails_sent_to": recipient_emails,
                    "guest_order": order.user is None,
                    "discount_applied": str(order.discount_amount),
                },
                status=status.HTTP_201_CREATED,
            )

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class OrderPlacerCompactor(viewsets.ModelViewSet):
    serializer_class = OrderSerializer
    permission_classes = [IsAuthenticatedOrReadOnly]

    def get_queryset(self):
        """
        Optimize queryset with select_related + prefetch_related.
        Authenticated → filter by user.
        Guest → no filtering, only manual lookup allowed.
        """
        qs = (
            Order.objects
            .select_related("user")
            .prefetch_related(
                Prefetch("items", queryset=OrderItem.objects.select_related("product")),
                Prefetch("addresses", queryset=OrderAddress.objects.all()),
            )
            .order_by("-created_at")
        )

        if self.request.user.is_authenticated:
            return qs.filter(user=self.request.user)
        return Order.objects.none()

    @action(detail=True, methods=["get"])
    def summary(self, request, pk=None):
        """
        GET /orders/{id}/summary/
        - Guest: fetch order by ID only
        - Authenticated: fetch order by ID and request.user
        """
        qs = Order.objects.select_related("user").prefetch_related(
            Prefetch("items", queryset=OrderItem.objects.all()),
            Prefetch("addresses", queryset=OrderAddress.objects.all()),
        )

        if request.user.is_authenticated:
            order = qs.filter(id=pk, user=request.user).first()
        else:
            order = qs.filter(id=pk).first()

        if not order:
            return Response(
                {"detail": "Order not found."},
                status=status.HTTP_404_NOT_FOUND
            )

        data = {
            "id": str(order.id),
            "status": order.get_status_display(),
            "total_amount": order.total_amount,
            "currency": order.currency,
            "items_count": order.items.count(),
            "addresses": [str(addr) for addr in order.addresses.all()],
        }
        return Response(data, status=status.HTTP_200_OK)