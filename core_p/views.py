from rest_framework.response import Response
from rest_framework import viewsets

class ProductViewSet(viewsets.ViewSet):

    def create(self, request):
        # Logic to create a product
        
        return Response({"message": "Product created"})
    
    def list(self, request):
        # Logic to list products
        return Response({"message": "List of products"})
    
    def retrieve(self, request, pk=None):
        # Logic to retrieve a single product
        return Response({"message": f"Product {pk} details"})
    
    