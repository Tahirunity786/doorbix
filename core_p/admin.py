from django.contrib import admin
from .models import Product,Inventory,Discount, DiscountUsage,ProductMeta,ProductReview, InventoryHistory, ProductCategory, ProductCollection, ProductImageSchema, ProductShipping, ProductVariant, PCTags
# Register your models here.


admin.site.register(ProductCategory)
admin.site.register(ProductCollection)
admin.site.register(ProductImageSchema)
admin.site.register(ProductShipping)
admin.site.register(ProductVariant)
admin.site.register(PCTags)
admin.site.register(ProductMeta)
admin.site.register(ProductReview)


@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = (
        'productName',
        'productPrice',
        'productStock',
        'productIsActive',
        'productIsFeatured',
        'productIsOnSale',
    )
    
    list_editable = (
        'productPrice',
        'productStock',
        'productIsActive',
        'productIsFeatured',
        'productIsOnSale',
    )

    search_fields = ('productName', 'productSKU', 'productBarcode')
    list_filter = ('productIsActive', 'productIsFeatured', 'productIsOnSale')
    ordering = ('-productCreatedAt',)

@admin.register(Inventory)
class InventoryAdmin(admin.ModelAdmin):
    list_display = ['id', 'product', 'variant', 'quantity', 'is_low_stock', 'updated_at']
    search_fields = ['product__productName', 'variant__variantName']

@admin.register(InventoryHistory)
class InventoryHistoryAdmin(admin.ModelAdmin):
    list_display = ['inventory', 'change_type', 'quantity', 'timestamp', 'remarks']
    list_filter = ['change_type', 'timestamp']
    search_fields = ['inventory__product__productName', 'inventory__variant__variantName']


class DiscountUsageInline(admin.TabularInline):
    """
    Inline to show all usages of a discount inside the Discount admin page.
    """
    model = DiscountUsage
    extra = 0
    readonly_fields = ("used_by", "order_reference", "timestamp", "amount")
    can_delete = False

@admin.register(Discount)
class DiscountAdmin(admin.ModelAdmin):
    list_display = ("name", "code", "discount_type", "value", "active", "start_date", "end_date", "priority")
    list_filter = ("active", "discount_type", "start_date", "end_date")
    search_fields = ("name", "code", "description")
    ordering = ("-priority", "name")
    date_hierarchy = "start_date"
    inlines = [DiscountUsageInline]
    filter_horizontal = ("products", "variants", "categories", "collections")

@admin.register(DiscountUsage)
class DiscountUsageAdmin(admin.ModelAdmin):
    list_display = ("discount", "used_by", "order_reference", "timestamp", "amount")
    list_filter = ("timestamp", "discount")
    search_fields = ("order_reference", "used_by__username", "discount__name")
    ordering = ("-timestamp",)