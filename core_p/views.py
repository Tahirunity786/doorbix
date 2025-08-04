from rest_framework.response import Response
from rest_framework import viewsets, status
from django.shortcuts import get_object_or_404
from django.core.cache import cache
from django.utils.encoding import iri_to_uri

from .models import Product, ProductCollection
from .serializer import ProductSerializer, MiniProductSerializer, ProductCollectionSerializer


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

        # Create a unique cache key based on query parameters
        cache_key = f"products:list:type={product_type}&quantity={product_quantity}"
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
            try:
                quantity = int(product_quantity)
                queryset = queryset[:quantity]
            except ValueError:
                return Response({'error': 'Invalid quantity. Must be an integer.'}, status=400)

        serializer = MiniProductSerializer(queryset, many=True)
        data = serializer.data

        # Cache the data for 5 minutes (300 seconds)
        cache.set(cache_key, data, timeout=300)
        return Response(data)

    def retrieve(self, request, pk=None):
        slug = iri_to_uri(pk)
        cache_key = f"products:detail:{slug}"
        cached_data = cache.get(cache_key)

        if cached_data:
            return Response(cached_data, status=status.HTTP_200_OK)

        try:
            product = get_object_or_404(Product, productSlug=slug)
            serializer = ProductSerializer(product)
            data = serializer.data
            cache.set(cache_key, data, timeout=300)
            return Response(data, status=status.HTTP_200_OK)
        except Exception as e:
            return Response(
                {"error": "Something went wrong", "details": str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )


class CollectionViewset(viewsets.ViewSet):

    def list(self, request):
        cache_key = "collections:list"
        cached_data = cache.get(cache_key)

        if cached_data:
            return Response(cached_data, status=status.HTTP_200_OK)

        try:
            collections = ProductCollection.objects.all()
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
