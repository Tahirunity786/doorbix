from uuid import UUID
from rest_framework.response import Response
from rest_framework import viewsets, status
from django.shortcuts import get_object_or_404
from django.core.cache import cache
from django.utils.encoding import iri_to_uri


from .models import Product, ProductCategory, ProductCollection
from .serializer import ProductCategorySerializer, ProductSerializer, MiniProductSerializer, ProductCollectionSerializer, MiniCollectionSerializer

class ProductViewSet(viewsets.ViewSet):
    PRODUCT_TYPE_FILTERS = {
        'bestSelling': {'productIsBestSelling': True},
        'featuredProducts': {'productIsFeatured': True},
        'onSaleProducts': {'productIsOnSale': True},
        'subscriptionProduct': {'productIsForSubscription': True},
        'discountProduct': {'productIsDiscounted': True},
    }

    def list(self, request):
        product_type = request.query_params.get('type')
        product_quantity = request.query_params.get('quantity')
        allow_collection = request.query_params.get('collection')
        all_category = request.query_params.get('category')=="true"

        cache_key = f"products:list:type={product_type}&quantity={product_quantity}&collection={allow_collection}"
        cached_data = cache.get(cache_key)
        if cached_data:
            return Response(cached_data)

        queryset = Product.objects.all()

        if product_type in self.PRODUCT_TYPE_FILTERS:
            queryset = queryset.filter(
                **self.PRODUCT_TYPE_FILTERS[product_type],
                productIsActive="published"
            ).order_by('-productCreatedAt')

        if product_quantity:
            quantity = self._parse_int(product_quantity, "quantity")
            if quantity is None:
                return Response({'error': 'Invalid quantity. Must be an integer.'}, status=400)
            queryset = queryset[:quantity]

        data = MiniProductSerializer(queryset, many=True).data

        if allow_collection:
            collection_quantity = self._parse_int(allow_collection, "collection quantity")
            if collection_quantity is None:
                return Response({'error': 'Invalid collection quantity. Must be an integer.'}, status=400)
            collections = ProductCollection.objects.all()[:collection_quantity]

            data = {
                "products": data,
                "collections": MiniCollectionSerializer(collections, many=True).data
            }
        
        if all_category:
            categories = ProductCategory.objects.all().order_by('-created_at')
            data['categories'] = ProductCategorySerializer(categories, many=True).data
            

        cache.set(cache_key, data, timeout=300)
        return Response(data)

    def retrieve(self, request, pk=None):
        """
        Retrieve product by either UUID or slug.
        Supports caching for performance.
        Allows returning full or mini data via ?view=mini|full
        """
        identifier = iri_to_uri(pk)
        view_type = request.query_params.get("view", "full")  # default is full
    
        # Cache key depends on identifier + view type
        cache_key = f"products:detail:{identifier}:{view_type}"
        cached_data = cache.get(cache_key)
        if cached_data:
            return Response(cached_data, status=status.HTTP_200_OK)
    
        # Try to detect if pk is a UUID
        try:
            uuid_obj = UUID(str(identifier))
            filter_kwargs = {"id": uuid_obj}
        except (ValueError, TypeError):
            filter_kwargs = {"productSlug": identifier}
    
        # Fetch product
        product = get_object_or_404(Product, **filter_kwargs)
    
        # Choose serializer depending on view type
        if view_type == "mini":
            data = {
                "id": str(product.id),   # UUID string
                "slug": product.productSlug,
                "name": product.productName,
                "price": product.productPrice,
                "image": (
                    request.build_absolute_uri(product.productImages.first().image.url)
                    if product.productImages.exists() and product.productImages.first().image
                    else None
                ),
                "qty": 1,  # default quantity for cart/cart-like usage
            }
        else:
            data = ProductSerializer(product).data  # serializer.data
    
        # Cache data for 5 minutes
        cache.set(cache_key, data, timeout=300)
    
        return Response(data, status=status.HTTP_200_OK)



    def _parse_int(self, value, field_name):
        try:
            return int(value)
        except ValueError:
            return None



class CollectionViewset(viewsets.ViewSet):

    def list(self, request):
        cache_key = "collections:list"
        cached_data = cache.get(cache_key)
        product_quantity = request.query_params.get('quantity')

        if cached_data:
            return Response(cached_data, status=status.HTTP_200_OK)

        try:
            collections = ProductCollection.objects.all()
            if product_quantity:
                try:
                    quantity = int(product_quantity)
                    collections = collections[:quantity]
                except ValueError:
                    return Response({'error': 'Invalid quantity. Must be an integer.'}, status=400)

            serializer = ProductCollectionSerializer(collections, many=True)
            data = serializer.data
            cache.set(cache_key, data, timeout=300)
            return Response(data, status=status.HTTP_200_OK)
        except Exception as e:
            return Response(str(e), status=status.HTTP_400_BAD_REQUEST)

    def retrieve(self, request, pk=None):
        slug = iri_to_uri(pk)
        cache_key = f"collections:detail:{slug}"
        cached_data = cache.get(cache_key)

        if cached_data:
            return Response(cached_data, status=status.HTTP_200_OK)

        try:
            collection = get_object_or_404(ProductCollection, collectionSlug=slug)
            serializer = ProductCollectionSerializer(collection)
            data = serializer.data
            cache.set(cache_key, data, timeout=300)
            return Response(data, status=status.HTTP_200_OK)
        except Exception as e:
            return Response(
                {"error": "Something went wrong", "details": str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )
