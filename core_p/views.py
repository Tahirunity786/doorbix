from rest_framework.response import Response
from rest_framework import viewsets, status
from django.shortcuts import get_object_or_404

from .models import Product
from .serializer import ProductSerializer


class ProductViewSet(viewsets.ViewSet):

    def create(self, request):
        return Response({"message": "Product created"})
    
    def list(self, request):
        return Response({"message": "List of products"})
    
    def retrieve(self, request, pk=None):  # DRF uses 'pk' by default
        print(pk)
        try:
            product = get_object_or_404(Product, productSlug=pk)  # 'pk' holds slug here
            serializer = ProductSerializer(product)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(
                {"error": "Something went wrong", "details": str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )
    