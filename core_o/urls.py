from rest_framework.routers import DefaultRouter
from django.urls import path, include
from core_o.views import OrderPlacer,OrderPlacerCompactor, OrderTrackView

router  = DefaultRouter()

router.register(r'orders', OrderPlacerCompactor, basename='orders')


urlpatterns = [
    path('', include(router.urls)),
    # Additional paths can be added here
    path('place-order/', OrderPlacer.as_view(), name='place-order'),
    path("track/", OrderTrackView.as_view(), name="order-track"),
]
