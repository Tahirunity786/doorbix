from rest_framework.routers import DefaultRouter
from django.urls import path, include
from core_p.views import ProductViewSet, CollectionViewset, SearchProduct, CouponApplier

router  = DefaultRouter()


router.register(r'products', ProductViewSet, basename='product')
router.register(r'collections', CollectionViewset, basename='collection')


urlpatterns = [
    path('', include(router.urls)),
    # Additional paths can be added here
    path('search/', SearchProduct.as_view(), name="search"),
    path('coupon/', CouponApplier.as_view(), name="capply")
]