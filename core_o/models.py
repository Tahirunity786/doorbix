import uuid
from django.db import models
from django.conf import settings
from django.utils import timezone

from django.core.validators import RegexValidator


ISO_COUNTRY_VALIDATOR = RegexValidator(
    regex=r"^[A-Z]{2}$",
    message="Use ISO 3166-1 alpha-2 uppercase country code."
)

class Order(models.Model):
    class Status(models.TextChoices):
        PENDING     = "PEN", "Pending"
        PROCESSING  = "PRO", "Processing"
        COMPLETED   = "COM", "Completed"
        CANCELED    = "CAN", "Canceled"
        REFUNDED    = "REF", "Refunded"

    id = models.UUIDField(default=uuid.uuid4, editable=False, primary_key=True, unique=True, db_index=True)

    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="orders",
        db_index=True
    )

    # Totals
    subtotal_amount = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    shipping_amount = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    tax_amount      = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    discount_amount = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    total_amount    = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    currency        = models.CharField(max_length=3, default="AED", db_index=True)

    status = models.CharField(max_length=3, choices=Status.choices, default=Status.PENDING, db_index=True)
    payment_reference = models.CharField(max_length=64, blank=True, null=True, db_index=True)

    created_at = models.DateTimeField(default=timezone.now, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "orders"
        indexes = [
            models.Index(fields=["user", "created_at"]),
            models.Index(fields=["status", "created_at"]),
        ]
        ordering = ["-created_at"]

    def __str__(self):
        return f"Order {self.order_id} ({self.get_status_display()})"



class OrderAddress(models.Model):
    class AddressType(models.TextChoices):
        BILLING  = "BIL", "Billing"
        SHIPPING = "SHP", "Shipping"
        
    id = models.UUIDField(default=uuid.uuid4, editable=False, primary_key=True, unique=True, db_index=True)

    order = models.ForeignKey(
        "Order",
        on_delete=models.CASCADE,
        related_name="addresses",
        db_index=True
    )

    address_type = models.CharField(max_length=3, choices=AddressType.choices, db_index=True)
    first_name    = models.CharField(max_length=120)
    last_name    = models.CharField(max_length=120)
    # email        = models.EmailField(max_length=255, db_index=True)
    phone        = models.CharField(max_length=20, blank=True)

    line1        = models.CharField(max_length=120)
    line2        = models.CharField(max_length=120, blank=True)
    city         = models.CharField(max_length=80)
    state        = models.CharField(max_length=80, blank=True)
    postal_code  = models.CharField(max_length=20, db_index=True)
    country      = models.CharField(max_length=2, validators=[ISO_COUNTRY_VALIDATOR], db_index=True)

    created_at = models.DateTimeField(default=timezone.now)

    class Meta:
        db_table = "order_addresses"
        indexes = [
            models.Index(fields=["address_type", "postal_code"]),
            models.Index(fields=["country", "postal_code"]),
        ]

    def __str__(self):
        return f"{self.get_address_type_display()} Address for Order {self.order_id}"

class OrderItem(models.Model):
    order = models.ForeignKey(
        "Order",
        on_delete=models.CASCADE,
        related_name="items",
        db_index=True
    )
    id = models.UUIDField(default=uuid.uuid4, editable=False, primary_key=True, unique=True, db_index=True)

    product_id = models.UUIDField(editable=False, db_index=True)  # could also be FK if products are local
    name       = models.CharField(max_length=255)  # snapshot of product name
    quantity   = models.PositiveIntegerField()
    unit_price = models.DecimalField(max_digits=12, decimal_places=2)
    total_price= models.DecimalField(max_digits=12, decimal_places=2)

    class Meta:
        db_table = "order_items"
        indexes = [
            models.Index(fields=["order", "product_id"]),
        ]

    def __str__(self):
        return f"{self.quantity} x {self.name} (Order {self.order_id})"
