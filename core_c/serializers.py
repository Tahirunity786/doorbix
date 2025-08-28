from django.utils.text import Truncator
from rest_framework import serializers
from .models import SupportTicket


class SupportTicketCreateSerializer(serializers.ModelSerializer):
    """
    Public serializer for creating a ticket from the Contact form.
    Includes:
      - defensive input normalization
      - honeypot anti-spam field (`website`)
    """

    # Honeypot: real users never see/fill this; bots often do.
    website = serializers.CharField(
        required=False, allow_blank=True, write_only=True
    )

    class Meta:
        model = SupportTicket
        fields = [
            "name",
            "email",
            "message",
            "website",  # honeypot
        ]

    def validate(self, attrs):
        # Honeypot check
        if attrs.get("website"):
            raise serializers.ValidationError(
                {"non_field_errors": ["Suspicious activity detected."]}
            )

        # Normalize & trim
        name = (attrs.get("name") or "").strip()
        email = (attrs.get("email") or "").strip().lower()
        message = (attrs.get("message") or "").strip()

        # Basic guardrails
        if len(name) < 2:
            raise serializers.ValidationError({"name": "Please enter your full name."})
        if len(message) < 10:
            raise serializers.ValidationError({"message": "Message is too short."})
        if len(message) > 5000:
            # Hard cap to prevent abuse
            message = Truncator(message).chars(5000)

        attrs["name"] = name
        attrs["email"] = email
        attrs["message"] = message
        return attrs

    def create(self, validated_data):
        # Remove honeypot field if present
        validated_data.pop("website", None)

        # IP / UA passed from view via serializer.save(ip_address=..., user_agent=...)
        return SupportTicket.objects.create(**validated_data)


class SupportTicketCreatedResponseSerializer(serializers.ModelSerializer):
    """
    Response payload returned to the frontend after creation.
    """

    class Meta:
        model = SupportTicket
        fields = ["ticket_no", "created_at"]
        read_only_fields = fields
