import uuid
from rest_framework import status, viewsets, generics
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticatedOrReadOnly
from django.shortcuts import get_object_or_404
from rest_framework import serializers
from .models import BlogPost, Comments
from .serializer import (
    BlogPostListSerializer,
    BlogPostDetailSerializer,
    BlogPostCreateSerializer,
    CommentSerializer
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

class CommentListCreateView(generics.ListCreateAPIView):
    """
    GET -> List approved top-level comments for a blog post
    POST -> Create a new top-level comment or reply
    """

    serializer_class = CommentSerializer

    def get_queryset(self):
        post_id = self.kwargs.get("id")
        return (
            Comments.objects.filter(
                post_id=post_id,
                is_approved=True,
                comment_on_comment__isnull=True,  # only top-level
            )
            .select_related("post")
            .prefetch_related("comments_set")
            .order_by("-created_at")
        )

    def perform_create(self, serializer):
        post_id = self.kwargs.get("id")
        post = get_object_or_404(BlogPost, id=post_id)

        parent_comment = serializer.validated_data.get("comment_on_comment")
        if parent_comment and parent_comment.post_id != post.id:
            raise serializers.ValidationError(
                {"comment_on_comment": "Reply must belong to the same blog post."}
            )

        serializer.save(post=post)
