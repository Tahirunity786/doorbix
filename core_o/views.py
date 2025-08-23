from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from django.db.models import Prefetch
from rest_framework.permissions import AllowAny, IsAuthenticatedOrReadOnly
from .models import Order, OrderItem, OrderAddress
from .serializers import OrderSerializer


class OrderPlacer(APIView):
    permission_classes = [AllowAny]  # guest + auth both can place

    def post(self, request):
        serializer = OrderSerializer(data=request.data, context={"request": request})
        
        if serializer.is_valid():
            order = serializer.save()  # no need to pass user manually, serializer handles it

            return Response(
                {
                    "message": "Order placed successfully!",
                    "order_id": order.id,
                    "guest_order": order.user is None  # quick flag
                },
                status=status.HTTP_201_CREATED,
            )

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class OrderPlacerCompactor(viewsets.ModelViewSet):
    serializer_class = OrderSerializer
    permission_classes = [IsAuthenticatedOrReadOnly]

    def get_queryset(self):
        """
        Optimize queryset with select_related + prefetch_related.
        Authenticated → filter by user.
        Guest → no filtering, only manual lookup allowed.
        """
        qs = (
            Order.objects
            .select_related("user")
            .prefetch_related(
                Prefetch("items", queryset=OrderItem.objects.select_related("product")),
                Prefetch("addresses", queryset=OrderAddress.objects.all()),
            )
            .order_by("-created_at")
        )

        if self.request.user.is_authenticated:
            return qs.filter(user=self.request.user)
        return Order.objects.none()

    @action(detail=True, methods=["get"])
    def summary(self, request, pk=None):
        """
        GET /orders/{id}/summary/
        - Guest: fetch order by ID only
        - Authenticated: fetch order by ID and request.user
        """
        print("I'm here")
        qs = Order.objects.select_related("user").prefetch_related(
            Prefetch("items", queryset=OrderItem.objects.all()),
            Prefetch("addresses", queryset=OrderAddress.objects.all()),
        )
        print("I'm here 2")

        if request.user.is_authenticated:
            order = qs.filter(id=pk, user=request.user).first()
            print("I'm here inner")
        else:
            order = qs.filter(id=pk).first()
            print("I'm here inner 2")
        print("I'm here 3")

        if not order:
            return Response(
                {"detail": "Order not found."},
                status=status.HTTP_404_NOT_FOUND
            )

        print("I'm here 4")
        data = {
            "id": str(order.id),
            "status": order.get_status_display(),
            "total_amount": order.total_amount,
            "currency": order.currency,
            "items_count": order.items.count(),
            "addresses": [str(addr) for addr in order.addresses.all()],
        }
        return Response(data, status=status.HTTP_200_OK)