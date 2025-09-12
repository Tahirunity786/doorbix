import uuid
from rest_framework import serializers
from django.contrib.auth import get_user_model
from django.contrib.auth.hashers import make_password

User = get_user_model()

class UserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'first_name', 'last_name', 'password']
        read_only_fields = ['id', 'username']

    def create(self, validated_data):
        validated_data['password'] = make_password(validated_data['password'])

        # Auto-generate username if not provided
        if not validated_data.get('username'):
            email = validated_data.get('email', '')
            base = email.split('@')[0] if email else str(uuid.uuid4())[:8]
            username = base
            counter = 0
            while User.objects.filter(username=username).exists():
                counter += 1
                username = f"{base}{counter}"
            validated_data['username'] = username

        return super().create(validated_data)

class SubscriptionSerializer(serializers.Serializer):
    email = serializers.EmailField()

    def validate_email(self, value):
        if not value:
            raise serializers.ValidationError("Email is required.")
        return value

    def create(self, validated_data):
        from .models import Subscription
        subscription, created = Subscription.objects.get_or_create(email=validated_data['email'])
        if not created:
            raise serializers.ValidationError("This email is already subscribed.")
        return subscription