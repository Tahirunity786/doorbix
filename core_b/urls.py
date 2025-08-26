from rest_framework.routers import DefaultRouter
from django.urls import path, include

from .views import BlogPostViewSet, CommentListCreateView

router = DefaultRouter()

router.register(r'content',BlogPostViewSet, basename="blogPost")


urlpatterns = [
    path('', include(router.urls)),
    # Additional paths can be added here
    path('<uuid:id>/comments/', CommentListCreateView.as_view())
]