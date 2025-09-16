from rest_framework import serializers
from django.contrib.auth import get_user_model
from .models import (
    Coupon,
    Product,
    ProductReview,
    ProductVariant,
    ProductImageSchema,
    ProductCategory,
    ProductCollection,
    ProductShipping,
    PCTags
)

User = get_user_model()

# ----------- User Serializer -----------
class UserSerializer(serializers.ModelSerializer):
    full_name = serializers.SerializerMethodField()

    class Meta:
        model = User
        fields = ['full_name']

    def get_full_name(self, obj):
        return obj.get_full_name() if hasattr(obj, "get_full_name") else f"{obj.first_name} {obj.last_name}".strip()


# ----------- Tag Serializer -----------
class PCTagSerializer(serializers.ModelSerializer):
    class Meta:
        model = PCTags
        fields = ['id', 'name']


# ----------- Product Image Serializer -----------
class ProductImageSerializer(serializers.ModelSerializer):
    image = serializers.SerializerMethodField()  # ✅ tell DRF to use get_image

    class Meta:
        model = ProductImageSchema
        fields = ['id', 'image']

    def get_image(self, obj):
        if obj.image and hasattr(obj.image, "url"):
            return obj.image.url  # relative URL like "/media/..."
        return None

class ProductReviewSerializer(serializers.ModelSerializer):
    rating_image = serializers.ImageField(required=False, allow_null=True)  # ✅ Optional image
    product_id = serializers.UUIDField(write_only=True)  # ✅ Write-only field (not returned in response)
    reviewd_by = UserSerializer(read_only=True)  # ✅ Always set from request.user

    class Meta:
        model = ProductReview
        fields = [
            'id',
            'reviewd_by',
            'review_to',
            'product_id',
            'rating_image',
            'rating',
            'rating_comment',
        ]
        read_only_fields = ["id", "reviewd_by", "review_to"]

    def create(self, validated_data):
        request = self.context.get("request")
        product_id = validated_data.pop("product_id")
        
        # ✅ Get product instance safely
        try:
            product = Product.objects.get(id=product_id)
        except Product.DoesNotExist:
            raise serializers.ValidationError({"product_id": "Invalid product ID."})

        # ✅ Save review with auth user and product
        return ProductReview.objects.create(
            reviewd_by=request.user,
            review_to=product,
            **validated_data
        )

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
    average_rating = serializers.SerializerMethodField()  # optional: avg rating


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
            'productStock',
            'average_rating',
        ]
    def get_average_rating(self, obj):
        reviews = obj.productreview_set.all()
        if not reviews.exists():
            return None
        return round(sum([r.rating for r in reviews]) / reviews.count(), 2)

        
# ----------- Product Collection Serializer -----------
class ProductCollectionSerializer(serializers.ModelSerializer):
    collectionTags = PCTagSerializer(many=True)
    products = MiniProductSerializer(many=True, read_only=True)  
    categories = serializers.SerializerMethodField()

    class Meta:
        model = ProductCollection
        fields = [
            'id',
            'collectionName',
            'collectionSlug',
            'collectionImage',
            'collectionDescription',
            'collectionTags',
            'products',
            'categories',  # ✅ new field
        ]

    def get_categories(self, obj):
        # Get distinct categories from related products
        categories = ProductCategory.objects.all()
        return ProductCategorySerializer(categories, many=True).data



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
    reviews = ProductReviewSerializer(many=True, read_only=True, source='productreview_set')
    average_rating = serializers.SerializerMethodField()  # optional: avg rating


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
            'reviews',
            'average_rating',
        ]
    def get_average_rating(self, obj):
        reviews = obj.productreview_set.all()
        if not reviews.exists():
            return None
        return round(sum([r.rating for r in reviews]) / reviews.count(), 2)

class CouponSerializer(serializers.Serializer):
    code = serializers.CharField()

    def validate_code(self, value):
        if not value:
            raise serializers.ValidationError("Coupon is required.")
        return value