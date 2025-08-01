from rest_framework.routers import DefaultRouter
from django.urls import path, include
from core_p.views import ProductViewSet

router  = DefaultRouter()

router.register(r'products', ProductViewSet, basename='product')


urlpatterns = [
    path('', include(router.urls)),
    # Additional paths can be added here
]