from decimal import Decimal, ROUND_HALF_UP
from rest_framework import generics, serializers
from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from django.db.models import Prefetch
from rest_framework.permissions import AllowAny, IsAuthenticatedOrReadOnly
from django.db import transaction
from core_a.models import Subscription
from core_p.models import Coupon, CouponUsage
from .models import CouriorInfo, Order, OrderItem, OrderAddress
from .serializers import OrderSerializer, OrderTrackSerializer
from django.conf import settings
from django.utils import timezone
from django.template.loader import render_to_string
from django.core.mail import EmailMultiAlternatives
from rest_framework.throttling import AnonRateThrottle

class OrderPlacer(APIView):
    """
    Handles order placement:
    - Validates serializer
    - Applies coupon discount if provided
    - Distributes discount across items
    - Tracks coupon usage
    - Sends confirmation email
    """
    permission_classes = [AllowAny]

    def post(self, request):
        serializer = OrderSerializer(data=request.data, context={"request": request})

        if not serializer.is_valid():
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

        with transaction.atomic():
            # Save base order & items
            order = serializer.save()
            code = serializer.validated_data.get("code")

            # =============================
            # APPLY DISCOUNT (from coupon)
            # =============================
            if code:
                self._apply_coupon_discount(order, code)

            # =============================
            # EMAIL SENDING
            # =============================
            self._send_confirmation_email(order)

        return Response(
            {
                "message": "Order placed successfully!",
                "order_id": order.id,
                "emails_sent_to": [addr.email for addr in order.addresses.all() if addr.email],
                "guest_order": order.user is None,
            },
            status=status.HTTP_201_CREATED,
        )

    # -----------------------------
    # Helpers
    # -----------------------------

    def _apply_coupon_discount(self, order, code: str):
        """Apply discount from coupon and update usage tracking."""
        # Get primary email (for guest subscriptions)
        email = order.addresses.first().email if order.addresses.exists() else None
        subscription, _ = Subscription.objects.get_or_create(email=email) if email else (None, None)

        try:
            coupon = Coupon.objects.get(code=code, active=True)
        except Coupon.DoesNotExist:
            return  # Invalid coupon → ignore silently

        if order.subtotal_amount <= 0:
            return

        # Compute discount value
        discount_percent = coupon.discount_percentage
        discount_value = (
            order.subtotal_amount * Decimal(discount_percent) / Decimal(100)
        ).quantize(Decimal("0.01"), rounding=ROUND_HALF_UP)

        # Update order totals
        order.discount_amount = discount_value
        order.total_amount = (
            order.subtotal_amount + order.shipping_amount + order.tax_amount
        ) - discount_value
        order.save(update_fields=["discount_amount", "total_amount"])

        # Spread discount proportionally across items
        for item in order.items.all():
            proportion = item.total_price / order.subtotal_amount
            line_discount = (discount_value * proportion).quantize(
                Decimal("0.01"), rounding=ROUND_HALF_UP
            )
            item.discount_amount = line_discount
            item.total_price = item.total_price - line_discount
            item.save(update_fields=["discount_amount", "total_price"])

        # Track usage (if subscription exists)
        if subscription:
            usage = CouponUsage.objects.filter(coupon=coupon, subscription=subscription).first()
            usage_count = usage.usage_count if usage else 0

            if coupon.usage_limit and usage_count >= coupon.usage_limit:
                raise serializers.ValidationError(
                    {"code": f"Oops! You have already used this coupon {coupon.usage_limit} times."}
                )

            if usage:
                usage.usage_count += 1
                usage.save(update_fields=["usage_count"])
            else:
                CouponUsage.objects.create(coupon=coupon, subscription=subscription, usage_count=1)

    def _send_confirmation_email(self, order):
        """Send order confirmation email to all associated addresses."""
        recipient_emails = list(
            {addr.email.strip() for addr in order.addresses.all() if addr.email}
        )
        if not recipient_emails:
            print(f"Order {order.order_number} placed (⚠ no email found)")
            return

        try:
            context = {
                "user": {"name": order.user.first_name if order.user else "Guest"},
                "order": {
                    "order_number": order.order_number,
                    "id": order.id,
                    "subtotal": order.subtotal_amount,
                    "shipping": order.shipping_amount,
                    "discount": order.discount_amount,
                    "total": order.total_amount,
                    "currency": order.currency,
                    "items": [
                        {
                            "name": item.name,
                            "quantity": item.quantity,
                            "price": item.unit_price,
                            "line_total": item.total_price,
                            "discount": item.discount_amount,
                        }
                        for item in order.items.all()
                    ],
                    "tracking_url": f"https://doorbix.com/orders/{order.id}/track/",
                },
                "current_year": timezone.now().year,
            }

            html_content = render_to_string("email/order.html", context)
            text_content = f"Thank you for your order {order.order_number}. Total: {order.total_amount} {order.currency}"

            email = EmailMultiAlternatives(
                subject=f"Your Order Confirmation: {order.order_number}",
                body=text_content,
                from_email=settings.DEFAULT_FROM_EMAIL,
                to=recipient_emails,
            )
            email.attach_alternative(html_content, "text/html")
            email.send(fail_silently=False)

        except Exception as e:
            print(f"⚠ Email sending failed for order {order.id}: {e}")

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
        qs = Order.objects.select_related("user").prefetch_related(
            Prefetch("items", queryset=OrderItem.objects.all()),
            Prefetch("addresses", queryset=OrderAddress.objects.all()),
        )
    
        if request.user.is_authenticated:
            order = qs.filter(id=pk, user=request.user).first()
        else:
            order = qs.filter(id=pk).first()
    
        if not order:
            return Response(
                {"detail": "Order not found."},
                status=status.HTTP_404_NOT_FOUND
            )
    
        # 🔹 Build items list
        items_data = [
            {
                "id": str(item.id),
                "product_id": str(item.product_id),
                "name": item.name,
                "quantity": item.quantity,
                "unit_price": item.unit_price,
                "total_price": item.total_price,
                
            }
            for item in order.items.all()
        ]
    
        data = {
            "id": str(order.id),
            "status": order.get_status_display(),
            "total_amount": float(order.total_amount),
            "discount_amount": order.discount_amount,
            "currency": order.currency,
            "items_count": order.items.count(),
            "items": items_data,  # ✅ include all items
            "addresses": [str(addr) for addr in order.addresses.all()],
        }
        return Response(data, status=status.HTTP_200_OK)


class OrderTrackView(generics.GenericAPIView):
    """
    API endpoint to check order tracking info by `order_number`.

    Example: GET /api/orders/track/?order_number=DBX-20250904-0001
    """

    serializer_class = OrderTrackSerializer

    def get(self, request, *args, **kwargs):
        order_number = request.query_params.get("order_number")
        if not order_number:
            return Response({"detail": "Order number is required."},
                            status=status.HTTP_400_BAD_REQUEST)

        try:
            order = Order.objects.prefetch_related("courior").get(order_number=order_number)
        except Order.DoesNotExist:
            return Response({"detail": "Order not found."},
                            status=status.HTTP_404_NOT_FOUND)

        serializer = self.get_serializer(order)
        return Response(serializer.data, status=status.HTTP_200_OK)