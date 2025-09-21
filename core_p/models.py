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

class VariantValue(models.Model):
    """
    Represents a specific value of a product variant.
    Example:
        - For variantType "Size", values might be "Small", "Medium", "Large".
        - For variantType "Color", values might be "Red", "Blue", "Green".
    """
    id = models.UUIDField(
        primary_key=True,
        default=uuid.uuid4,
        editable=False
    )
    valueImage = models.ImageField(
        upload_to='variant_value_images/',
        null=True,
        blank=True,
        help_text="Optional image representing the variant value (e.g., color swatch)."
    )
    valueName = models.CharField(
        max_length=100,
        db_index=True,  # Faster lookups
        help_text="Display name of the variant value (e.g., 'Red', 'XL')."
    )
    valuePrice = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        default=0.00,
        help_text="Additional price adjustment for this variant value (if any)."
    )
    valueSKU = models.CharField(
        max_length=100,
        default="",
        unique=True,
        help_text="Unique Stock Keeping Unit identifier for this variant value."
    )
    valueStock = models.PositiveIntegerField(
        default=0,
        help_text="Available stock quantity for this specific variant value."
    )
    valueBarcode = models.CharField(
        max_length=100,
        unique=True,
        null=True,
        blank=True,
        help_text="Optional unique barcode for scanning / inventory systems."
    )

    class Meta:
        verbose_name = "Variant Value"
        verbose_name_plural = "Variant Values"
        ordering = ["valueName"]

    def __str__(self):
        return f"{self.valueName} (SKU: {self.valueSKU})"


class ProductVariant(models.Model):
    """
    Represents a variant type (e.g., Size, Color) for a product.
    A product can have multiple variants (e.g., Size + Color).
    Each variant can have multiple values (e.g., Size -> S, M, L).
    """
    VARIANT_CHOICES = [
        ('size', 'Size'),
        ('color', 'Color'),
        ('material', 'Material'),
        ('style', 'Style'),
        ('pattern', 'Pattern'),
        ('length', 'Length'),
        ('width', 'Width'),
        ('height', 'Height'),
        ('weight', 'Weight'),
        ('volume', 'Volume'),
        ('capacity', 'Capacity'),
        ('flavor', 'Flavor'),
        ('scent', 'Scent'),
        ('brand', 'Brand'),
        ('model', 'Model'),
        ('edition', 'Edition'),
        ('other', 'Other'),
    ]

    id = models.UUIDField(
        primary_key=True,
        default=uuid.uuid4,
        editable=False
    )
    variantType = models.CharField(
        max_length=255,
        choices=VARIANT_CHOICES,
        default='other',
        db_index=True,
        help_text="Defines the type of variant (e.g., Size, Color)."
    )
    variantValue = models.ManyToManyField(
        VariantValue,
        related_name='variants',
        blank=True,
        help_text="List of possible values for this variant (e.g., 'Red', 'Blue')."
    )
    variantIsActive = models.BooleanField(
        default=True,
        help_text="Indicates whether this variant is currently active."
    )
    variantCreatedAt = models.DateTimeField(
        auto_now_add=True,
        help_text="Timestamp when this variant was created."
    )
    variantUpdatedAt = models.DateTimeField(
        auto_now=True,
        help_text="Timestamp when this variant was last updated."
    )

    # Self-referencing relationship for hierarchical variants
    parentVariant = models.ForeignKey(
        'self',
        null=True,
        blank=True,
        related_name='childVariants',
        on_delete=models.CASCADE,
        help_text="Parent variant (if this is a sub-variant)."
    )

    class Meta:
        verbose_name = "Product Variant"
        verbose_name_plural = "Product Variants"
        ordering = ["variantType"]

    def __str__(self):
        return f"{self.get_variantType_display()}"  # Human-readable label
    
class ProductReview(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    reviewd_by = models.ForeignKey(User, on_delete=models.CASCADE, db_index=True, null=True, blank=True)
    review_to = models.ForeignKey('Product', on_delete=models.CASCADE, db_index=True)
    rating_image = models.ImageField(upload_to='rating_product', blank=True, null=True)
    rating = models.DecimalField(max_digits=3, decimal_places=2, default=0.00, db_index=True)
    rating_comment = models.TextField(db_index=True)

    def __str__(self):
        return f'Review for {self.review_to.productName}'

    

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

class Coupon(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    code = models.CharField(max_length=50, unique=True)
    discount_percentage = models.DecimalField(max_digits=5, decimal_places=2)
    active = models.BooleanField(default=True)
    expires_at = models.DateTimeField(null=True, blank=True)
    usage_limit = models.IntegerField(default=5)  # max usage per user
    created_at = models.DateTimeField(auto_now_add=True)

    def is_valid(self):
        if not self.active:
            return False
        if self.expires_at and timezone.now() > self.expires_at:
            return False
        return True

class CouponUsage(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True)
    coupon = models.ForeignKey(Coupon, on_delete=models.CASCADE)
    used_at = models.DateTimeField(auto_now_add=True)
    usage_count = models.IntegerField(default=1)
    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=['coupon', 'user'],
                name='unique_coupon_subscription_user'
            )
        ]
        indexes = [
            models.Index(fields=['coupon', 'user']),
        ]
    def clean(self):
        if self.usage_count < 1:
            raise ValidationError("Usage count must be at least 1.")
        if self.coupon.usage_limit and self.usage_count > self.coupon.usage_limit:
            raise ValidationError(f"Usage count cannot exceed coupon limit of {self.coupon.usage_limit}.")