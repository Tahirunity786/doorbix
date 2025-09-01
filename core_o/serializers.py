from rest_framework import serializers
from django.db import transaction
from .models import Order, OrderItem, OrderAddress
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
    Serializer for creating and retrieving orders.
    Handles nested items and addresses.
    """
    items = OrderItemSerializer(many=True, write_only=True)
    addresses = OrderAddressSerializer(many=True, write_only=True)

    class Meta:
        model = Order
        fields = [
            "id", "status", "user", "subtotal_amount", "total_amount",
            "items", "addresses"
        ]
        read_only_fields = [
            "id", "status", "created_at", "updated_at",
            "subtotal_amount", "total_amount", "user"  # user should be readonly
        ]

    def create(self, validated_data):
        request = self.context.get("request")

        # Extract nested data
        items_data = validated_data.pop("items", [])
        addresses_data = validated_data.pop("addresses", [])

        # ✅ Assign user only if authenticated
        user = request.user if request and request.user.is_authenticated else None

        # Create Order
        order = Order.objects.create(user=user, **validated_data)

        subtotal = 0

        # Create Order Items
        for item_data in items_data:
            product_id = item_data.pop("product_id")
            quantity = item_data.get("quantity", 1)

            try:
                product = Product.objects.get(id=product_id)
            except Product.DoesNotExist:
                raise serializers.ValidationError(
                    {"items": f"Product with id {product_id} does not exist."}
                )

            order_item = OrderItem.objects.create(
                order=order,
                product_id=product_id,
                product_SKU=product.productSKU,
                name=product.productName,
                quantity=quantity,
                unit_price=product.productPrice,
                total_price=product.productPrice * quantity
            )
            subtotal += order_item.total_price

        # Create Addresses
        for addr_data in addresses_data:
            OrderAddress.objects.create(order=order, **addr_data)

        # Update totals
        order.subtotal_amount = subtotal
        order.total_amount = subtotal  # if tax/shipping, update here
        order.save()

        return order
