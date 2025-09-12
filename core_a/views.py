from django.contrib.auth import get_user_model
from rest_framework import viewsets, status
from rest_framework.response import Response
from rest_framework.response import Response
from .serializer import UserSerializer
from django.shortcuts import get_object_or_404
from .utiles import create_jwt_token
from django.contrib.auth import authenticate
from rest_framework.decorators import action

User = get_user_model()
class UserViewSet(viewsets.ViewSet):
    """
    A ViewSet for managing users.
    Supports:
      - list (GET /users/)
      - retrieve (GET /users/{id}/)
      - create/register (POST /users/)
      - login (POST /users/login/)
    """

    def list(self, request):
        """List all users (Admin only in production)."""
        queryset = User.objects.all()
        serializer = UserSerializer(queryset, many=True)
        return Response(serializer.data)

    def retrieve(self, request, pk=None):
        """Retrieve a specific user by ID."""
        queryset = User.objects.all()
        user = get_object_or_404(queryset, pk=pk)
        serializer = UserSerializer(user)
        return Response(serializer.data)

    def create(self, request):
        """
        Register a new user.
        Automatically hashes the password and returns JWT tokens.
        """
        serializer = UserSerializer(data=request.data, context={'request': request})
        if serializer.is_valid():
            user = serializer.save()
            tokens = create_jwt_token(user)

            return Response({
                "user": {
                    "id": user.id,
                    "username": user.username,
                    "email": user.email,
                    "first_name": user.first_name,
                    "last_name": user.last_name,
                },
                "tokens": tokens
            }, status=status.HTTP_201_CREATED)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['post'], url_path='login')
    def login(self, request):
        """
        Login an existing user.
        Validates email & password and returns JWT tokens.
        """
        email = request.data.get('email')
        password = request.data.get('password')

        if not email or not password:
            return Response({"detail": "Email and password are required."},
                            status=status.HTTP_400_BAD_REQUEST)

        # Authenticate using email
        try:
            user_obj = User.objects.get(email=email)
        except User.DoesNotExist:
            return Response({"detail": "Invalid email or password."},
                            status=status.HTTP_401_UNAUTHORIZED)

        user = authenticate(username=user_obj.username, password=password)
        if not user:
            return Response({"detail": "Invalid email or password."},
                            status=status.HTTP_401_UNAUTHORIZED)

        tokens = create_jwt_token(user)

        return Response({
           "user": {
                "id": user.id,
                "username": user.username,
                "email": user.email,
                "first_name": user.first_name,
                "last_name": user.last_name,
            },
            "tokens": tokens
        }, status=status.HTTP_200_OK)

class SubscriptionViewSet(viewsets.ViewSet):
    """
    A ViewSet for managing email subscriptions.
    Supports:
      - create/subscribe (POST /subscribe/)
    """

    def create(self, request):
        """
        Subscribe a new email.
        Validates the email and ensures it's not already registered as a user.
        """
        from .serializer import SubscriptionSerializer
        serializer = SubscriptionSerializer(data=request.data)
        if serializer.is_valid():
            subscription = serializer.save()
            return Response({
                "email": subscription.email,
                "subscribed_at": subscription.subscribed_at
            }, status=status.HTTP_201_CREATED)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)  