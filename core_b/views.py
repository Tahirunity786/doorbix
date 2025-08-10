from rest_framework import status, viewsets
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticatedOrReadOnly
from django.shortcuts import get_object_or_404
from .models import BlogPost
from .serializer import (
    BlogPostListSerializer,
    BlogPostDetailSerializer,
    BlogPostCreateSerializer
)


class BlogPostViewSet(viewsets.ViewSet):
    """
    A ViewSet for listing, retrieving, and creating blog posts.
    Uses slug for retrieval to support SEO-friendly URLs.
    """
    permission_classes = [IsAuthenticatedOrReadOnly]
    lookup_field = "slug"

    def get_queryset(self):
        """
        Base queryset with optimized related data fetching.
        """
        return BlogPost.objects.select_related("blogCategory").prefetch_related("blogTags")

    def list(self, request):
        """
        GET /api/blogposts/
        Returns:
        - All published blog posts (default)
        - If category_wise=true → One latest published post from each category
        """
        category_difference = request.query_params.get('category_wise') == "true"
    
        queryset = self.get_queryset().filter(is_published=True)
    
        if category_difference:
            # Dictionary to store one post per category
            latest_posts = {}
            # Fetch posts ordered by category and created_at
            posts = queryset.order_by('blogCategory__name', '-created_at')
            for post in posts:
                if post.blogCategory_id not in latest_posts:
                    latest_posts[post.blogCategory_id] = post
            queryset = latest_posts.values()
    
        serializer = BlogPostListSerializer(queryset, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    


    def retrieve(self, request, slug=None):
        """
        GET /api/blogposts/<slug>/  
        Returns a detailed blog post.
        """
        post = get_object_or_404(self.get_queryset(), slug=slug, is_published=True)
        serializer = BlogPostDetailSerializer(post)
        return Response(serializer.data, status=status.HTTP_200_OK)

    def create(self, request):
        """
        POST /api/blogposts/  
        Creates a new blog post (auth required).
        """
        serializer = BlogPostCreateSerializer(data=request.data)
        if serializer.is_valid():
            post = serializer.save()
            return Response(
                BlogPostDetailSerializer(post).data,
                status=status.HTTP_201_CREATED
            )
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
