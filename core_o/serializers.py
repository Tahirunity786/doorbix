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

    class Meta:
        model = OrderAddress
        fields = [
            "id", "address_type", "first_name", "last_name", "phone",
            "line1", "line2", "city", "state", "postal_code", "country"
        ]
        read_only_fields = ["id"]


class OrderSerializer(serializers.ModelSerializer):
    """
    Main serializer for creating and retrieving orders.
    Handles nested items and addresses.
    """
    items = OrderItemSerializer(many=True, write_only=True)
    addresses = OrderAddressSerializer(many=True, write_only=True)

    class Meta:
        model = Order
        fields = [
            "id", "status", "subtotal_amount", "total_amount",
            "items", "addresses" # ✅ output
        ]
        read_only_fields = [
            "id", "status", "created_at", "updated_at",
            "subtotal_amount", "total_amount",
        ]

    