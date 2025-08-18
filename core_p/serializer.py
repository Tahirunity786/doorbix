from rest_framework import serializers
from .models import (
    Product,
    ProductVariant,
    ProductImageSchema,
    ProductCategory,
    ProductCollection,
    ProductShipping,
    PCTags
)





# ----------- Tag Serializer -----------
class PCTagSerializer(serializers.ModelSerializer):
    class Meta:
        model = PCTags
        fields = ['id', 'name']


# ----------- Product Image Serializer -----------
class ProductImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductImageSchema
        fields = ['id', 'image']


# ----------- Recursive Variant Serializer -----------
class ProductVariantSerializer(serializers.ModelSerializer):
    # Recursively serialize child variants (multi-level nesting)
    childVariants = serializers.SerializerMethodField()

    class Meta:
        model = ProductVariant
        fields = [
            'id',
            'variantName',
            'variantPrice',
            'variantSKU',
            'variantStock',
            'variantBarcode',
            'variantIsActive',
            'variantCreatedAt',
            'variantUpdatedAt',
            'childVariants'
        ]

    def get_childVariants(self, obj):
        # Recursive serialization of child variants
        children = obj.childVariants.all()
        return ProductVariantSerializer(children, many=True).data


# ----------- Product Category Serializer -----------
class ProductCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductCategory
        fields = ['id', 'categoryName']



# ----------- Mini Version Serializer -----------
class MiniCollectionSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductCollection
        fields = [
            'id',
            'collectionName',
            'collectionSlug',
            'collectionImage',
            'collectionDescription',
        ]

class MiniProductSerializer(serializers.ModelSerializer):
    id = serializers.UUIDField(format='hex', read_only=True)
    productImages = ProductImageSerializer(many=True, required=False)
    productVariant = ProductVariantSerializer(required=False)

    class Meta:
        model = Product  # Make sure to replace with your actual Product model
        fields = [
            'id',
            'productSlug',
            'productName',
            'productDescription',
            'productPrice',
            'productComparePrice',
            'productImages',
            'productVariant',
        ]

        
# ----------- Product Collection Serializer -----------
class ProductCollectionSerializer(serializers.ModelSerializer):
    collectionTags = PCTagSerializer(many=True)
    products = MiniProductSerializer(many=True, read_only=True)  # Use Mini or Full Product Serializer

    class Meta:
        model = ProductCollection
        fields = [
            'id',
            'collectionName',
            'collectionSlug',
            'collectionImage',
            'collectionDescription',
            'collectionTags',
            'products'  # Include related products
        ]



# ----------- Product Shipping Serializer -----------
class ProductShippingSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductShipping
        fields = ['id', 'shippingUnit', 'shippingWeight']


# ----------- Main Product Serializer -----------



class ProductSerializer(serializers.ModelSerializer):
    # Related field serializers
    id = serializers.UUIDField(format='hex', read_only=True)
    productCategory = ProductCategorySerializer(many=True)
    productImages = ProductImageSerializer(many=True, required=False)
    productTags = PCTagSerializer(many=True, required=False)
    productCollection = ProductCollectionSerializer(many=True, required=False)
    productShipping = ProductShippingSerializer(required=False)
    productVariant = ProductVariantSerializer(required=False)

    class Meta:
        model = Product
        depth = 1
        fields = [
            'id',
            'productName',
            'productDescription',
            'productPrice',
            'productCostPrice',
            'productComparePrice',
            'productCategory',
            'productStock',
            'productSKU',
            'productImages',
            'productSlug',
            'productShipping',
            'productTags',
            'productCollection',
            'productType',
            'productVendor',
            'productVariant',
            'productSaleCountinue',
        ]


