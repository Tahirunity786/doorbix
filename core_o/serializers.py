from decimal import Decimal
from rest_framework import serializers
from django.db import transaction
from django.utils import timezone
from .models import CouriorInfo, Order, OrderItem, OrderAddress
from core_p.models import Product


class OrderItemSerializer(serializers.ModelSerializer):
    product_id = serializers.UUIDField(write_only=True)

    class Meta:
        model = OrderItem
        fields = ["id", "product_id", "name", "quantity", "unit_price", "total_price"]
        read_only_fields = ["id", "name", "unit_price", "total_price"]

    def create(self, validated_data):
        # extract product_id
        product_id = validated_data.pop("product_id")
        quantity = validated_data.get("quantity", 1)

        # get product from DB
        try:
            product = Product.objects.get(id=product_id)
        except Product.DoesNotExist:
            raise serializers.ValidationError(f"Product with id {product_id} does not exist.")

        # populate fields from Product
        validated_data["name"] = product.productName
        validated_data["unit_price"] = product.productPrice
        validated_data["total_price"] = product.productPrice * quantity
        validated_data["product_id"] = product.id  # FK assignment

        return super().create(validated_data)


class OrderAddressSerializer(serializers.ModelSerializer):
    """
    Serializer for order addresses (shipping/billing).
    """
    email = serializers.EmailField(required=False, allow_blank=True, allow_null=True)

    class Meta:
        model = OrderAddress
        fields = [
            "id", "address_type", "fullName", "phone","email",
            "line1", "line2", "state", "country"
        ]
        read_only_fields = ["id"]
class OrderSerializer(serializers.ModelSerializer):
    """
    Handles creation of orders with nested items & addresses.
    - User is auto-assigned if authenticated
    - Subtotal & totals are computed
    - Coupon code is passed through (handled in view)
    """
    items = OrderItemSerializer(many=True, write_only=True)
    addresses = OrderAddressSerializer(many=True, write_only=True)
    code = serializers.CharField(write_only=True, required=False, allow_blank=True, allow_null=True)

    class Meta:
        model = Order
        fields = [
            "id", "status", "user", "subtotal_amount", "total_amount",
            "items", "addresses", "code"
        ]
        read_only_fields = [
            "id", "status", "created_at", "updated_at",
            "subtotal_amount", "total_amount", "user"
        ]

    def create(self, validated_data):
        request = self.context.get("request")
        items_data = validated_data.pop("items", [])
        addresses_data = validated_data.pop("addresses", [])
        validated_data.pop("code", None)  # handled in view

        # Assign user if logged in
        user = request.user if request and request.user.is_authenticated else None

        # Create base order
        order = Order.objects.create(user=user, **validated_data)

        subtotal = Decimal("0.00")

        for item_data in items_data:
            product_id = item_data.pop("product_id")
            quantity = item_data.get("quantity", 1)

            try:
                product = Product.objects.get(id=product_id)
            except Product.DoesNotExist:
                raise serializers.ValidationError({
                    "code": "PRODUCT_NOT_FOUND",
                    "message": f"Product with ID {product_id} does not exist."
                })

            if product.productStock < quantity:
                raise serializers.ValidationError({
                    "code": "OUT_OF_STOCK",
                    "message": f"Product '{product.productName}' is out of stock. Please contact support."
                })

            order_item = OrderItem.objects.create(
                order=order,
                product_id=product_id,
                product_SKU=product.productSKU,
                name=product.productName,
                quantity=quantity,
                unit_price=product.productPrice,
                total_price=product.productPrice * quantity,
            )

            subtotal += order_item.total_price

            # Update stock
            product.productStock -= quantity
            product.save(update_fields=["productStock"])

        for addr_data in addresses_data:
            OrderAddress.objects.create(order=order, **addr_data)

        order.subtotal_amount = subtotal
        order.total_amount = subtotal
        order.save(update_fields=["subtotal_amount", "total_amount"])

        return order


class CouriorInfoSerializer(serializers.ModelSerializer):
    """Serialize courier details linked with an order."""

    class Meta:
        model = CouriorInfo
        fields = ["coriour_name", "tracking_id"]


class OrderTrackSerializer(serializers.ModelSerializer):
    """Serializer to expose only tracking-related fields for frontend order tracking."""

    courier = CouriorInfoSerializer(source="courior", many=True, read_only=True)
    status_display = serializers.CharField(source="get_status_display", read_only=True)

    class Meta:
        model = Order
        fields = [
            "order_number",      # Friendly order ID (DBX-20250904-0001)
            "status",            # Enum value ("PEN", "PRO", "SHI", "CAN")
            "status_display",    # Human-readable ("Pending", "Processing", "Shipped", etc.)
            "courier",           # Nested courier info
            "updated_at",        # Last update timestamp
        ]
