from rest_framework.routers import DefaultRouter
from django.urls import path, include

from .views import BlogPostViewSet

router = DefaultRouter()

router.register(r'content',BlogPostViewSet, basename="blogPost")


urlpatterns = [
    path('', include(router.urls)),
    # Additional paths can be added here
]