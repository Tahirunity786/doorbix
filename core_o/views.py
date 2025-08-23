from rest_framework import viewsets, permissions
from rest_framework.response import Response
from rest_framework.decorators import action
from django.db.models import Prefetch
from .models import Order, OrderItem, OrderAddress
from .serializers import OrderSerializer


class OrderPlacer(viewsets.ModelViewSet):
    """
    Handle placing, listing, and retrieving orders
    for the authenticated user.
    """
    serializer_class = OrderSerializer
    # permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return (
            Order.objects.filter(user=self.request.user)
            .select_related("user")
            .prefetch_related(
                Prefetch("items", queryset=OrderItem.objects.all()),
                Prefetch("addresses", queryset=OrderAddress.objects.all()),
            )
            .order_by("-created_at")
        )

    def perform_create(self, serializer):
        return serializer.save()

    @action(detail=True, methods=["get"])
    def summary(self, request, pk=None):
        """
        Custom endpoint to quickly get summary of an order.
        """
        order = self.get_object()
        data = {
            "id": order.id,
            "status": order.get_status_display(),
            "total_amount": order.total_amount,
            "currency": order.currency,
            "items_count": order.items.count(),
            "addresses": [str(addr) for addr in order.addresses.all()],
        }
        return Response(data)
