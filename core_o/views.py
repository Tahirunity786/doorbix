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
from core_p.models import Coupon, CouponUsage
from .models import Order, OrderItem, OrderAddress
from .serializers import OrderSerializer, OrderTrackSerializer
from django.conf import settings
from django.utils import timezone
from django.template.loader import render_to_string
from django.db.models import F
from django.core.mail import EmailMultiAlternatives
from rest_framework.throttling import AnonRateThrottle
from django.contrib.auth import get_user_model

User = get_user_model()
class OrderPlacer(APIView):
    """
    Handles order placement:
      - Validates serializer
      - Creates order/items/addresses
      - Optionally applies coupon (coupon application REQUIRES authenticated user)
      - Distributes discount across items (rounded; residual adjustment)
      - Tracks coupon usage (using CouponUsage.subscription_user)
      - Sends confirmation email
    """
    permission_classes = [AllowAny]

    def post(self, request):
        serializer = OrderSerializer(data=request.data, context={"request": request})
        if not serializer.is_valid():
            return Response(
                {
                    "success": False,
                    "code": "VALIDATION_ERROR",
                    "errors": serializer.errors,
                },
                status=status.HTTP_400_BAD_REQUEST
            )

        try:
            with transaction.atomic():
                order = serializer.save()

                code = serializer.validated_data.get("code")
                if code:
                    if not request.user or not request.user.is_authenticated:
                        return Response(
                            {
                                "success": False,
                                "code": "AUTH_REQUIRED",
                                "message": "You must be logged in to use a coupon."
                            },
                            status=status.HTTP_403_FORBIDDEN
                        )
                    self._apply_coupon_discount(order=order, code=code, request_user=request.user)

                self._send_confirmation_email(order)

            return Response(
                {
                    "success": True,
                    "code": "ORDER_PLACED",
                    "message": "Order placed successfully.",
                    "order_id": order.id,
                    "emails_sent_to": [addr.email for addr in order.addresses.all() if addr.email],
                    "guest_order": order.user is None,
                },
                status=status.HTTP_201_CREATED
            )

        except serializers.ValidationError as e:
            # These already have professional codes/messages
            return Response(
                {"success": False, **e.detail},
                status=status.HTTP_400_BAD_REQUEST
            )
        except Exception as e:
            # Catch-all for unexpected errors
            print(e)
            return Response(
                {
                    "success": False,
                    "code": "SERVER_ERROR",
                    "message": "An unexpected error occurred. Please try again later."
                },
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )

    # -----------------------------
    # Helpers
    # -----------------------------
    def _apply_coupon_discount(self, order, code, request_user):
        """
        Apply discount and track coupon usage.

        - Only called if request_user is authenticated (enforced by caller).
        - Locks coupon row with select_for_update to avoid race conditions on usage limits.
        - Distributes discount to items, corrects rounding residual on final item.
        - Updates/creates CouponUsage using subscription_user field (matches your model).
        """
        if order.subtotal_amount <= Decimal("0.00"):
            # Nothing to discount
            return

        # Lock coupon row to prevent concurrent over-usage
        try:
            coupon = Coupon.objects.select_for_update().get(code=code, active=True)
        except Coupon.DoesNotExist:
            raise serializers.ValidationError({"code": "Invalid coupon code."})

        # Compute discount
        discount_percent = coupon.discount_percentage or Decimal("0")
        discount_value = (
            (order.subtotal_amount * Decimal(discount_percent) / Decimal(100))
            .quantize(Decimal("0.01"), rounding=ROUND_HALF_UP)
        )

        if discount_value <= Decimal("0.00"):
            # no effective discount
            return

        # Enforce usage limit (CouponUsage is unique per coupon & subscription_user)
        usage = CouponUsage.objects.filter(coupon=coupon, user=request_user).first()
        usage_count = usage.usage_count if usage else 0
        if coupon.usage_limit and usage_count >= coupon.usage_limit:
            raise serializers.ValidationError(
                {"code": f"You have already used this coupon {coupon.usage_limit} times."}
            )

        # Update order totals
        order.discount_amount = discount_value
        # assume shipping & tax fields exist and default to 0 if not set
        shipping = getattr(order, "shipping_amount", Decimal("0.00")) or Decimal("0.00")
        tax = getattr(order, "tax_amount", Decimal("0.00")) or Decimal("0.00")
        new_total = (order.subtotal_amount + shipping + tax) - discount_value
        # prevent negative total
        order.total_amount = new_total if new_total > Decimal("0.00") else Decimal("0.00")
        order.save(update_fields=["discount_amount", "total_amount"])

        # Distribute discount across items proportionally and fix rounding residual
        items = list(order.items.select_for_update().all())  # lock items while updating
        if not items:
            return

        # compute distributed discounts and keep track of residual
        distributed_sum = Decimal("0.00")
        last_index = len(items) - 1

        for idx, item in enumerate(items):
            proportion = (
                (item.total_price / order.subtotal_amount)
                if order.subtotal_amount > Decimal("0.00")
                else Decimal("0.00")
            )
            # Round to cents
            line_discount = (discount_value * proportion).quantize(Decimal("0.01"), rounding=ROUND_HALF_UP)

            # For the last item, assign residual so total matches discount_value exactly
            if idx == last_index:
                residual = discount_value - distributed_sum
                line_discount = residual.quantize(Decimal("0.01"), rounding=ROUND_HALF_UP)

            distributed_sum += line_discount

            # Update fields on item
            item.discount_amount = line_discount
            item.save(update_fields=["discount_amount"])

        # Track coupon usage (increment or create)
        if usage:
            usage.usage_count = F("usage_count") + 1
            usage.save(update_fields=["usage_count"])
            # refresh from DB to get integer value if needed elsewhere
            usage.refresh_from_db()
        else:
            CouponUsage.objects.create(coupon=coupon, user=request_user, usage_count=1)

    def _send_confirmation_email(self, order: "Order"):
        """
        Send order confirmation email to associated addresses.
        This is best-effort: failure to send email will not rollback the order.
        """
        recipient_emails = list({addr.email.strip() for addr in order.addresses.all() if addr.email})
        if not recipient_emails:
            print(f"Order {getattr(order, 'order_number', order.id)} placed (⚠ no email found)")
            return

        try:
            context = {
                "user": {"name": order.user.first_name if order.user else "Guest"},
                "order": {
                    "order_number": getattr(order, "order_number", ""),
                    "id": order.id,
                    "subtotal": order.subtotal_amount,
                    "shipping": getattr(order, "shipping_amount", Decimal("0.00")),
                    "discount": getattr(order, "discount_amount", Decimal("0.00")),
                    "total": order.total_amount,
                    "currency": getattr(order, "currency", ""),
                    "items": [
                        {
                            "name": item.name,
                            "quantity": item.quantity,
                            "price": item.unit_price,
                            "line_total": item.total_price,
                            "discount": getattr(item, "discount_amount", Decimal("0.00")),
                        }
                        for item in order.items.all()
                    ],
                    "tracking_url": f"https://doorbix.com/track-order?o={order.id}",
                },
                "current_year": timezone.now().year,
            }

            html_content = render_to_string("email/order.html", context)
            text_content = f"Thank you for your order {getattr(order, 'order_number', order.id)}. Total: {order.total_amount} {getattr(order, 'currency', '')}"

            email = EmailMultiAlternatives(
                subject=f"Your Order Confirmation: {getattr(order, 'order_number', order.id)}",
                body=text_content,
                from_email=settings.DEFAULT_FROM_EMAIL,
                to=recipient_emails,
            )
            email.attach_alternative(html_content, "text/html")
            email.send(fail_silently=False)

        except Exception as e:
            # We avoid raising here because sending email should not block order creation.
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
    
        first_address = order.addresses.first()
        data = {
            "id": str(order.id),
            "order_id": order.order_number,
            "msg_info": True if (first_address and first_address.email) else False,
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