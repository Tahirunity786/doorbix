from rest_framework.routers import DefaultRouter
from django.urls import path, include
from core_o.views import OrderPlacer

router  = DefaultRouter()

router.register(r'orders', OrderPlacer, basename='orders')


urlpatterns = [
    path('', include(router.urls)),
    # Additional paths can be added here
]
