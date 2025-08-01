import uuid
from django.db import models
from django.utils import timezone


# Create your models here.

class PCTags(models.Model):
    name = models.CharField(max_length=100, unique=True)
    def __str__(self):
        return self.name

class ProductMeta(models.Model):
    metaTitle = models.CharField(max_length=255)
    metaDescription = models.TextField()
    metaKeywords = models.TextField()

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
    variantSKU = models.CharField(max_length=100, unique=True)
    variantStock = models.PositiveIntegerField(default=0)
    variantBarcode = models.CharField(max_length=100, unique=True, null=True, blank=True)
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
    

class ProductImageSchema(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    image = models.ImageField(upload_to='product_images/')
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Image for {self.product.productName}"

class ProductCategory(models.Model):
    categoryName = models.CharField(max_length=255, unique=True)
    created_at = models.DateTimeField(auto_now_add=True)
    

    def __str__(self):
        return self.categoryName
    
class ProductCollection(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    collectionName = models.CharField(max_length=255, unique=True)
    collectionImage = models.ImageField(upload_to='collection_images/', blank=True, null=True)
    collectionTags = models.ManyToManyField(PCTags, related_name='collections', blank=True)
    collectionDescription = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.collectionName
    
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
    productDescription = models.TextField()
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
    productRating = models.DecimalField(max_digits=3, decimal_places=2, default=0.00, blank=True, null=True)
    productReviewsCount = models.PositiveIntegerField(default=0, blank=True, null=True)
    productIsFeatured = models.BooleanField(default=False)
    productIsOnSale = models.BooleanField(default=False)
    productSaleCountinue = models.BooleanField(default=False)
    productIsTrackQuantity =  models.BooleanField(default=False)
    productCreatedAt = models.DateTimeField(auto_now_add=True)
    productUpdatedAt = models.DateTimeField(auto_now=True)
    productSeo = models.OneToOneField('ProductMeta', on_delete=models.CASCADE, related_name='products', null=True, blank=True)

    def __str__(self):
        return self.productName



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

    
