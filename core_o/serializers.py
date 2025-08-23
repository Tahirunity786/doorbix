from rest_framework import serializers
from .models import Order, OrderItem, OrderAddress


class OrderItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderItem
        fields = ["id", "product_id", "name", "quantity", "unit_price", "total_price"]
        read_only_fields = ["id", "total_price"]

    def validate_quantity(self, value):
        if value <= 0:
            raise serializers.ValidationError("Quantity must be greater than zero.")
        return value

    def create(self, validated_data):
        validated_data["total_price"] = validated_data["unit_price"] * validated_data["quantity"]
        return super().create(validated_data)


class OrderAddressSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderAddress
        fields = [
            "id", "address_type", "first_name", "last_name", "phone",
            "line1", "line2", "city", "state", "postal_code", "country"
        ]
        read_only_fields = ["id"]


class OrderSerializer(serializers.ModelSerializer):
    items = OrderItemSerializer(many=True)
    addresses = OrderAddressSerializer(many=True)

    class Meta:
        model = Order
        fields = [
            "id", "user", "subtotal_amount", "shipping_amount", "tax_amount",
            "discount_amount", "total_amount", "currency", "status",
            "payment_reference", "created_at", "updated_at", "items", "addresses"
        ]
        read_only_fields = ["id", "status", "user", "created_at", "updated_at", 
                            "subtotal_amount", "total_amount"]

    def create(self, validated_data):
        from django.db import transaction

        items_data = validated_data.pop("items", [])
        addresses_data = validated_data.pop("addresses", [])

        user = self.context["request"].user
        validated_data["user"] = user

        with transaction.atomic():
            order = Order.objects.create(**validated_data)

            subtotal = 0
            for item_data in items_data:
                total_price = item_data["unit_price"] * item_data["quantity"]
                subtotal += total_price
                OrderItem.objects.create(order=order, total_price=total_price, **item_data)

            for address_data in addresses_data:
                OrderAddress.objects.create(order=order, **address_data)

            order.subtotal_amount = subtotal
            order.total_amount = (
                subtotal + order.shipping_amount + order.tax_amount - order.discount_amount
            )
            order.save(update_fields=["subtotal_amount", "total_amount"])

        return order
