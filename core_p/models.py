from decimal import Decimal
import uuid
from django.db import models
from django.utils import timezone
from django.contrib.auth import get_user_model
from django.utils.text import slugify
from ckeditor.fields import RichTextField
from django.core.exceptions import ValidationError


User = get_user_model()


# Create your models here.

class PCTags(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    name = models.CharField(max_length=100, unique=True)
    def __str__(self):
        return self.name

class ProductMeta(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    metaTitle = models.CharField(max_length=255)
    metaDescription = models.TextField()
    metaKeywords = models.ManyToManyField(PCTags, related_name="metaTags", blank=True)

    def __str__(self):
        return self.metaTitle

    class Meta:
        verbose_name = 'Product Meta'
        verbose_name_plural = 'Product Metas'



class ProductVariant(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    variantImage = models.ImageField(upload_to='variant_images/')
    variantName = models.CharField(max_length=255)
    variantPrice = models.DecimalField(max_digits=10, decimal_places=2)
    variantSKU = models.CharField(max_length=100, unique=True, editable=False)
    variantStock = models.PositiveIntegerField(default=0)
    variantBarcode = models.CharField(max_length=100, unique=True, null=True, blank=True, editable=False)
    variantIsActive = models.BooleanField(default=True)
    variantCreatedAt = models.DateTimeField(auto_now_add=True)
    variantUpdatedAt = models.DateTimeField(auto_now=True)

    # Self-referencing relationship
    parentVariant = models.ForeignKey(
        'self',
        null=True,
        blank=True,
        related_name='childVariants',
        on_delete=models.CASCADE
    )

    def __str__(self):
        return self.variantName
    
class ProductReview(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    reviewd_by = models.ForeignKey(User, on_delete=models.CASCADE, db_index=True)
    review_to = models.ForeignKey('Product', on_delete=models.CASCADE, db_index=True)
    rating_image = models.ImageField(upload_to='rating_product', blank=True, null=True)
    rating = models.DecimalField(max_digits=3, decimal_places=2, default=0.00, db_index=True, blank=True, null=True)
    rating_comment = models.TextField(db_index=True)

    def __str__(self):
        return f'Review by {self.reviewd_by.get_full_name()} for {self.review_to.productName}'

    

class ProductImageSchema(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    image = models.ImageField(upload_to='product_images/')
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Image for {self.id}"

class ProductCategory(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    categoryName = models.CharField(max_length=255, unique=True)
    created_at = models.DateTimeField(auto_now_add=True)
    

    def __str__(self):
        return self.categoryName
    
class ProductCollection(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    collectionName = models.CharField(max_length=255, unique=True)
    collectionSlug = models.CharField(max_length=255, unique=True, blank=True, null=True,  default="")
    collectionImage = models.ImageField(upload_to='collection_images/')
    collectionTags = models.ManyToManyField(PCTags, related_name='collections', blank=True)
    collectionDescription = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.collectionName
    
    def save(self, *args, **kwargs):
        if not self.collectionSlug:
            base_slug = slugify(self.collectionName)
            unique_slug = base_slug
            num = 1
            while ProductCollection.objects.filter(collectionSlug=unique_slug).exists():
                unique_slug = f"{base_slug}-{num}"
                num += 1
            self.collectionSlug = unique_slug

        return super().save(*args, **kwargs)
    
class ProductShipping(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    shippingUnit = models.CharField(max_length=100, choices=[
        ('kg', 'Kilogram'),
        ('lb', 'Pound'),
        ('oz', 'Ounce'),
        ('g', 'Gram'),
    ], default='kg')
    shippingWeight = models.DecimalField(max_digits=10, decimal_places=2)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.shippingUnit} - {self.shippingUnit}"
    

class Product(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    productSlug = models.SlugField(max_length=255, unique=True, blank=True, null=True)
    productName = models.CharField(max_length=255, db_index=True)
    productImages = models.ManyToManyField(ProductImageSchema, related_name='products')
    productCollection = models.ManyToManyField(ProductCollection, related_name='products')
    productCategory = models.ManyToManyField(ProductCategory, related_name='products')
    productTags = models.ManyToManyField(PCTags, related_name='products', blank=True)
    productShipping = models.OneToOneField(ProductShipping, related_name='product', on_delete=models.CASCADE, null=True, blank=True)
    productVariant = models.ForeignKey(
        ProductVariant,
        related_name='products',
        on_delete=models.CASCADE,
        null=True,
        blank=True
    )
    productDescription = RichTextField()
    productPrice = models.DecimalField(max_digits=10, decimal_places=2)
    productCostPrice = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    productComparePrice = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    productStock = models.PositiveIntegerField(default=0)
    productType = models.CharField(max_length=100)
    productSKU = models.CharField(max_length=100, unique=True)
    productBarcode = models.CharField(max_length=100, unique=True, null=True, blank=True)
    productVendor = models.CharField(max_length=255)
    productIsActive = models.CharField(max_length=30, default='published', choices=[
        ('draft', 'Draft'),
        ('published', 'Published'),
        ('archived', 'Archived'),
        ])
    productIsFeatured = models.BooleanField(default=False)
    productIsOnSale = models.BooleanField(default=False)
    productIsBestSelling = models.BooleanField(default=False)
    productIsForSubscription = models.BooleanField(default=False)
    productSaleCountinue = models.BooleanField(default=False)
    productIsTrackQuantity =  models.BooleanField(default=False)
    productCreatedAt = models.DateTimeField(auto_now_add=True)
    productUpdatedAt = models.DateTimeField(auto_now=True)
    productSeo = models.OneToOneField('ProductMeta', on_delete=models.CASCADE, related_name='products', null=True, blank=True)

    def __str__(self):
        return self.productName
    
    def save(self, *args, **kwargs):
        if not self.productSlug:
            base_slug = slugify(self.productName)
            unique_slug = base_slug
            num = 1
            while Product.objects.filter(productSlug=unique_slug).exists():
                unique_slug = f"{base_slug}-{num}"
                num += 1
            self.productSlug = unique_slug

        return super().save(*args, **kwargs)



class Inventory(models.Model):
    """
    Inventory model to track stock for each Product or ProductVariant.
    Supports UUID for better scalability and security.
    """
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)

    # Link to Product (for simple products)
    product = models.OneToOneField(
        Product,
        on_delete=models.CASCADE,
        related_name='inventory',
        null=True,
        blank=True
    )

    # Link to Variant (for variant-based products)
    variant = models.OneToOneField(
        ProductVariant,
        on_delete=models.CASCADE,
        related_name='inventory',
        null=True,
        blank=True
    )

    # Current quantity in stock
    quantity = models.PositiveIntegerField(default=0)

    # Minimum threshold for alerts (e.g. low stock)
    low_stock_threshold = models.PositiveIntegerField(default=5)

    # Automatically track when inventory was updated
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        if self.product:
            return f"Inventory for Product: {self.product.productName}"
        elif self.variant:
            return f"Inventory for Variant: {self.variant.variantName}"
        return "Inventory Entry"

    def is_low_stock(self):
        """Returns True if current quantity is below threshold."""
        return self.quantity < self.low_stock_threshold

    def add_stock(self, amount: int):
        """Increase inventory quantity by a given amount."""
        self.quantity += amount
        self.save()
        InventoryHistory.objects.create(
            inventory=self,
            change_type='IN',
            quantity=amount,
            remarks='Restocked'
        )

    def remove_stock(self, amount: int):
        """
        Decrease inventory quantity by a given amount.
        Prevents negative inventory.
        """
        if amount > self.quantity:
            raise ValueError("Cannot remove more stock than available.")
        self.quantity -= amount
        self.save()
        InventoryHistory.objects.create(
            inventory=self,
            change_type='OUT',
            quantity=amount,
            remarks='Stock removed'
        )


class InventoryHistory(models.Model):
    """
    History of inventory changes for auditing and tracking.
    """
    CHANGE_CHOICES = (
        ('IN', 'Stock In'),
        ('OUT', 'Stock Out'),
    )

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    inventory = models.ForeignKey(
        Inventory,
        on_delete=models.CASCADE,
        related_name='history'
    )
    change_type = models.CharField(max_length=3, choices=CHANGE_CHOICES)
    quantity = models.PositiveIntegerField()
    timestamp = models.DateTimeField(default=timezone.now)
    remarks = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"{self.get_change_type_display()} - {self.quantity} on {self.timestamp.strftime('%Y-%m-%d %H:%M')}"

    
class Discount(models.Model):
    """
    Flexible discount/coupon model.

    Usage patterns supported:
      - Link to specific Product(s) via `products` M2M.
      - Link to specific ProductVariant(s) via `variants` M2M (optional).
      - Link to specific ProductCategory(s) via `categories` M2M.
      - Link to specific ProductCollection(s) via `collections` M2M.
      - If none of the target M2Ms are populated, the discount is treated as GLOBAL
        (applies to all products unless other constraints prevent it).
    """

    # --- Identity & basic metadata ---
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    name = models.CharField(max_length=180, help_text="Human readable name for admin")
    code = models.CharField(
        max_length=64,
        unique=True,
        null=True,
        blank=True,
        help_text="Optional coupon code. Leave blank for automatic discounts (no code required)."
    )
    description = models.TextField(blank=True, null=True)

    # --- Discount amount specification ---
    DISCOUNT_TYPE_PERCENT = "percent"
    DISCOUNT_TYPE_FIXED = "fixed"
    DISCOUNT_TYPE_CHOICES = [
        (DISCOUNT_TYPE_PERCENT, "Percentage"),
        (DISCOUNT_TYPE_FIXED, "Fixed amount"),
    ]
    discount_type = models.CharField(
        max_length=10,
        choices=DISCOUNT_TYPE_CHOICES,
        default=DISCOUNT_TYPE_PERCENT,
        help_text="Percentage will be applied as price * (value / 100). Fixed amount subtracts value from price."
    )
    # value meaning:
    # - if percent: value = 10.00 means 10% off
    # - if fixed: value = 5.00 means 5 currency units off
    value = models.DecimalField(max_digits=12, decimal_places=2)

    # --- Scope / target relations ---
    # Import your existing product-related models here. Adjust app names if different.
    # These fields are optional and can be left empty to indicate a global discount.
    products = models.ManyToManyField(
        "Product", related_name="discounts", blank=True,
        help_text="Products this discount explicitly applies to."
    )
    variants = models.ManyToManyField(
        "ProductVariant", related_name="discounts", blank=True,
        help_text="Optional: apply discount only to specific product variants."
    )
    categories = models.ManyToManyField(
        "ProductCategory", related_name="discounts", blank=True,
        help_text="Product categories this discount applies to."
    )
    collections = models.ManyToManyField(
        "ProductCollection", related_name="discounts", blank=True,
        help_text="Product collections this discount applies to."
    )

    # --- Conditions & rules ---
    start_date = models.DateTimeField(
        blank=True, null=True, help_text="If blank, discount is active immediately."
    )
    end_date = models.DateTimeField(
        blank=True, null=True, help_text="If blank, discount does not expire."
    )
    active = models.BooleanField(default=True, help_text="Master toggle for the discount.")
    combinable = models.BooleanField(
        default=False,
        help_text="If False, this discount cannot be stacked with other discounts in the same order."
    )
    minimum_order_value = models.DecimalField(
        max_digits=12, decimal_places=2, null=True, blank=True,
        help_text="Minimum cart / item value required to apply this discount (optional)."
    )

    # Usage limits
    usage_limit = models.PositiveIntegerField(
        null=True, blank=True,
        help_text="Maximum number of times this discount may be used across all users. Null = unlimited."
    )
    usage_limit_per_user = models.PositiveIntegerField(
        null=True, blank=True,
        help_text="Maximum number of times a single user may use this discount. Null = unlimited."
    )

    # Priority - higher priority discounts are considered first when resolving conflicts
    priority = models.IntegerField(default=0, help_text="Higher priority discounts are applied first.")

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ("-priority", "name")
        indexes = [
            models.Index(fields=["code"]),
            models.Index(fields=["active", "start_date", "end_date"]),
        ]

    def __str__(self):
        if self.code:
            return f"{self.name} ({self.code})"
        return self.name

    # -----------------------
    # Validation & utilities
    # -----------------------
    def clean(self):
        """
        Model-level validation:
          - start_date cannot be after end_date
          - If discount_type is percent, value must be between 0 and 100 (inclusive)
          - If no targets and no code and value == 0, warn/error (business choice)
        """
        if self.start_date and self.end_date and self.start_date > self.end_date:
            raise ValidationError({"end_date": "End date must be after start date."})

        if self.discount_type == self.DISCOUNT_TYPE_PERCENT:
            if self.value < Decimal("0.00") or self.value > Decimal("100.00"):
                raise ValidationError({"value": "Percentage discounts must be between 0 and 100."})
        else:
            if self.value < Decimal("0.00"):
                raise ValidationError({"value": "Fixed discount must be non-negative."})

        super().clean()

    def save(self, *args, **kwargs):
        # Normalize code to uppercase (if provided)
        if self.code:
            self.code = self.code.strip().upper()
        return super().save(*args, **kwargs)

    def is_active(self, at_time=None):
        """
        Check whether the discount is currently active (time window + active flag).
        """
        now = at_time or timezone.now()
        if not self.active:
            return False
        if self.start_date and now < self.start_date:
            return False
        if self.end_date and now > self.end_date:
            return False
        # Also check usage limit globally
        if self.usage_limit is not None:
            if self.get_total_usage_count() >= self.usage_limit:
                return False
        return True

    def get_total_usage_count(self):
        """
        Total times discount has been used (aggregated from DiscountUsage).
        """
        return self.usage.count()

    def get_user_usage_count(self, user):
        """
        Return how many times `user` has used this discount.
        """
        if not user or not user.is_authenticated:
            return 0
        return self.usage.filter(used_by=user).count()

    def applies_to_product(self, product):
        """
        Determine whether this discount is applicable to the given product/variant.
        - If variants M2M includes a variant matching -> True
        - If products M2M includes the product -> True
        - If categories intersects product.categories -> True
        - If collections intersects product.collections -> True
        - If none of the above target sets are populated -> treated as GLOBAL -> True
        """
        # Quick rejection if discount is not active now
        if not self.is_active():
            return False

        # If variants specified, check them first (most specific)
        if self.variants.exists():
            # product may have variants; if product passed is a ProductVariant instance, handle accordingly
            try:
                # If product passed is a ProductVariant instance
                if isinstance(product, ProductVariant):
                    return self.variants.filter(pk=product.pk).exists()
                # else check if any variant of the product is targeted
                return self.variants.filter(parentVariant__products__pk=product.pk).exists() or False
            except Exception:
                # In case product model doesn't have expected relations, continue checks
                pass

        # If products explicitly listed
        if self.products.exists():
            if getattr(product, "id", None) and self.products.filter(pk=product.id).exists():
                return True

        # Check categories
        if self.categories.exists():
            # assumes Product has ManyToMany named `productCategory` (per your schema)
            product_categories = getattr(product, "productCategory", None)
            if product_categories is not None:
                if self.categories.filter(pk__in=product_categories.all().values_list("pk", flat=True)).exists():
                    return True

        # Check collections
        if self.collections.exists():
            product_collections = getattr(product, "productCollection", None)
            if product_collections is not None:
                if self.collections.filter(pk__in=product_collections.all().values_list("pk", flat=True)).exists():
                    return True

        # If none of the target sets are configured, treat discount as global
        if not (self.products.exists() or self.variants.exists() or self.categories.exists() or self.collections.exists()):
            return True

        return False

    def calculate_discounted_price(self, original_price: Decimal) -> Decimal:
        """
        Given an original price (Decimal), return the price after applying this discount.
        This method does not check applicability rules (call `applies_to_product` first).
        """
        if not isinstance(original_price, Decimal):
            original_price = Decimal(original_price)

        if self.discount_type == self.DISCOUNT_TYPE_PERCENT:
            discount_amount = (original_price * (self.value / Decimal("100.00"))).quantize(original_price.as_tuple())
            final = original_price - discount_amount
        else:  # fixed
            final = original_price - self.value

        # Prevent negative price
        if final < Decimal("0.00"):
            final = Decimal("0.00")

        # Optionally round to 2 decimal places for currency
        return final.quantize(Decimal("0.01"))

    def can_be_used_by(self, user):
        """
        Check per-user usage limits (does not decrement usage).
        """
        if not self.is_active():
            return False
        if self.usage_limit_per_user is not None:
            if self.get_user_usage_count(user) >= self.usage_limit_per_user:
                return False
        return True


class DiscountUsage(models.Model):
    """
    Record each usage of a discount for auditing and enforcement of limits.
    Create one record when a discount is successfully applied to an order/checkout.
    """
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    discount = models.ForeignKey(
        Discount, on_delete=models.CASCADE, related_name="usage", help_text="Discount that was used."
    )
    used_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True, help_text="User who used it.")
    order_reference = models.CharField(max_length=255, blank=True, null=True,
                                       help_text="Optional: store order id/invoice reference for audit.")
    timestamp = models.DateTimeField(auto_now_add=True)
    amount = models.DecimalField(max_digits=12, decimal_places=2, null=True, blank=True,
                                 help_text="Monetary amount discounted in this usage (for audit).")

    class Meta:
        ordering = ("-timestamp",)
        indexes = [
            models.Index(fields=["discount"]),
            models.Index(fields=["used_by"]),
        ]

    def __str__(self):
        user_label = self.used_by.get_full_name() if self.used_by else "Anonymous"
        return f"{self.discount} used by {user_label} at {self.timestamp:%Y-%m-%d %H:%M}"

