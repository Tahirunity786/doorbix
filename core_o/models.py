import uuid
from django.db import models
from django.conf import settings
from django.utils import timezone

from django.core.validators import RegexValidator


# ISO_COUNTRY_VALIDATOR = RegexValidator(
#     regex=r"^[A-Z]{2}$",
#     message="Use ISO 3166-1 alpha-2 uppercase country code."
# )

class CouriorInfo(models.Model):
    id = models.UUIDField(default=uuid.uuid4, editable=False, primary_key=True, unique=True, db_index=True)
    order = models.ForeignKey("Order", on_delete=models.CASCADE, related_name="courior", db_index=True)
    coriour_name = models.CharField(max_length=100, db_index=True, default="")
    tracking_id = models.CharField(max_length=200, db_index=True, default="")
    created_at = models.DateTimeField(default=timezone.now, db_index=True)
    

class Order(models.Model):
    class Status(models.TextChoices):
        PENDING     = "PEN", "Pending"
        PROCESSING  = "PRO", "Processing"
        COMPLETED   = "SHI", "SHIPPED"
        CANCELED    = "CAN", "Canceled"

    id = models.UUIDField(default=uuid.uuid4, editable=False, primary_key=True, unique=True, db_index=True)

    # New friendly order ID
    order_number = models.CharField(max_length=20, unique=True, editable=False, db_index=True, blank=True, null=True)

    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="orders",
        db_index=True,
        null=True, blank=True 
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
        return f"Order {self.order_number} ({self.get_status_display()})"

    def save(self, *args, **kwargs):
        if not self.order_number:
            # Example: DBX-20250824-0001
            today = timezone.now().strftime("%Y%m%d")
            prefix = "DBX"
            
            # Count orders for today to generate a sequence
            count_today = Order.objects.filter(created_at__date=timezone.now().date()).count() + 1
            
            self.order_number = f"{prefix}-{today}-{count_today:04d}"
        
        super().save(*args, **kwargs)


class OrderAddress(models.Model):
    class UAEStates(models.TextChoices):
        # Example (You can expand this as per UAE states/emirates)
        ABU_DHABI = "AD", "Abu Dhabi"
        DUBAI = "DU", "Dubai"
        SHARJAH = "SH", "Sharjah"
        AJMAN = "AJ", "Ajman"
        UMM_AL_QUWAIN = "UQ", "Umm Al-Quwain"
        RAS_AL_KHAIMAH = "RK", "Ras Al-Khaimah"
        FUJAIRAH = "FJ", "Fujairah"

    class AddressType(models.TextChoices):
        BILLING = "BIL", "Billing"
        SHIPPING = "SHP", "Shipping"

    id = models.UUIDField(
        primary_key=True,
        default=uuid.uuid4,
        editable=False,
        unique=True,
        db_index=True
    )

    order = models.ForeignKey(
        "Order",
        on_delete=models.CASCADE,
        related_name="addresses",
        db_index=True
    )

    address_type = models.CharField(
        max_length=3,
        choices=AddressType.choices,
        db_index=True
    )

    fullName = models.CharField(max_length=120, default="")
    email = models.EmailField(max_length=255, db_index=True, null=True, blank=True)
    phone = models.CharField(max_length=20)
    line1 = models.CharField("Address Line 1", max_length=120)
    line2 = models.CharField("Address Line 2", max_length=120, blank=True)
    state = models.CharField(
        max_length=80,
        choices=UAEStates.choices,
        blank=True
    )
    country = models.CharField(max_length=50, db_index=True, default="UAE")
    created_at = models.DateTimeField(default=timezone.now, editable=False)

    class Meta:
        db_table = "order_addresses"
        verbose_name = "Order Address"
        verbose_name_plural = "Order Addresses"
        ordering = ["-created_at"]

    def __str__(self):
        return f" Address - {self.fullName} ({self.state})"
    
    
class OrderItem(models.Model):
    order = models.ForeignKey(
        "Order",
        on_delete=models.CASCADE,
        related_name="items",
        db_index=True
    )
    id = models.UUIDField(default=uuid.uuid4, editable=False, primary_key=True, unique=True, db_index=True)

    product_id = models.UUIDField(editable=False, db_index=True)  # could also be FK if products are local
    product_SKU = models.CharField(max_length=255, default="") 
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
        return f"{self.quantity} x {self.name} (Order {self.order.id})"
