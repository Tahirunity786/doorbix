from rest_framework.response import Response
from rest_framework import viewsets, status
from django.shortcuts import get_object_or_404

from .models import Product
from .serializer import ProductSerializer, MiniProductSerializer


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
        queryset = Product.objects.all()
    
        if product_type in self.PRODUCT_TYPE_FILTERS:
            queryset = queryset.filter(**self.PRODUCT_TYPE_FILTERS[product_type]).order_by('-productCreatedAt')
    
        # Limit the number of results if quantity is provided and valid
        if product_quantity:
            try:
                quantity = int(product_quantity)
                queryset = queryset[:quantity]
            except ValueError:
                return Response({'error': 'Invalid quantity. Must be an integer.'}, status=400)
    
        serializer = MiniProductSerializer(queryset, many=True)
        return Response(serializer.data)
    
    def retrieve(self, request, pk=None):  # DRF uses 'pk' by default
        try:
            product = get_object_or_404(Product, productSlug=pk)  # 'pk' holds slug here
            serializer = ProductSerializer(product)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except Exception as e:
            return Response(
                {"error": "Something went wrong", "details": str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )
    