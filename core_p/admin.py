from django.contrib import admin
from .models import Product,Inventory,ProductMeta, InventoryHistory, ProductCategory, ProductCollection, ProductImageSchema, ProductShipping, ProductVariant, PCTags
# Register your models here.


admin.site.register(ProductCategory)
admin.site.register(ProductCollection)
admin.site.register(ProductImageSchema)
admin.site.register(ProductShipping)
admin.site.register(ProductVariant)
admin.site.register(PCTags)
admin.site.register(ProductMeta)


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