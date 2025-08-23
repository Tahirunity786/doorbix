from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.views import APIView
from django.db.models import Prefetch
from rest_framework.permissions import AllowAny
from .models import Order, OrderItem, OrderAddress
from .serializers import OrderSerializer




class OrderPlacer(APIView):
    permission_classes = [AllowAny]  # Allow any user to place orders

    def post(self, request):
        """
        Place a new order with items and addresses.
        Expects JSON payload with items and addresses.
        """
        serializer = OrderSerializer(data=request.data)
        if serializer.is_valid():
            print(serializer.validated_data)

# class OrderPlacer(viewsets.ModelViewSet):
#     """
#     ViewSet for placing and managing user orders.
#     Handles:
#     - POST (place order)
#     - GET (list user's orders)
#     - GET detail (single order)
#     - Custom summary endpoint
#     """
#     serializer_class = OrderSerializer
#     # permission_classes = [permissions.IsAuthenticated]  # 🔐 Enable when auth is ready

#     def get_queryset(self):
#         """
#         Restrict orders to the logged-in user.
#         Prefetch related items and addresses for efficiency.
#         """
#         return (
#             Order.objects.filter(user=self.request.user)
#             .select_related("user")
#             .prefetch_related(
#                 Prefetch("items", queryset=OrderItem.objects.all()),
#                 Prefetch("addresses", queryset=OrderAddress.objects.all()),
#             )
#             .order_by("-created_at")
#         )

#     def perform_create(self, serializer):
#         """
#         Hook into create to log incoming validated data (for debugging).
#         """
#         print("✅ Order validated data:", serializer.validated_data)
#         return serializer.save()

#     @action(detail=True, methods=["get"])
#     def summary(self, request, pk=None):
#         """
#         Custom endpoint to quickly get a compact summary of an order.
#         Example: GET /orders/{id}/summary/
#         """
#         order = self.get_object()
#         data = {
#             "id": str(order.id),
#             "status": order.get_status_display(),
#             "total_amount": order.total_amount,
#             "currency": order.currency,
#             "items_count": order.items.count(),
#             "addresses": [str(addr) for addr in order.addresses.all()],
#         }
#         return Response(data)
