from rest_framework import serializers
from .models import BlogPost, Category, Tags


class TagSerializer(serializers.ModelSerializer):
    """Serializer for tags."""
    class Meta:
        model = Tags
        fields = ["id", "name", "slug"]


class CategorySerializer(serializers.ModelSerializer):
    """Serializer for categories."""
    class Meta:
        model = Category
        fields = ["id", "name", "slug", "description"]


class BlogPostListSerializer(serializers.ModelSerializer):
    """Serializer for listing blog posts with minimal data."""
    blogCategory = CategorySerializer(read_only=True)
    blogTags = TagSerializer(many=True, read_only=True)

    class Meta:
        model = BlogPost
        fields = [
            "id", "blogTitle", "slug", "blogExcerpt",
            "blogImage", "blogCategory", "blogTags", "views_count",
            "created_at"
        ]


class BlogPostDetailSerializer(serializers.ModelSerializer):
    """Serializer for detailed blog post view."""
    blogCategory = CategorySerializer(read_only=True)
    blogTags = TagSerializer(many=True, read_only=True)

    class Meta:
        model = BlogPost
        fields = [
            "id", "blogTitle", "slug", "blogDescription",
            "blogExcerpt", "blogImage", "blogCategory", "blogTags",
            "metaTitle", "metaDescription","views_count",
            "created_at", "updated_at"
        ]


class BlogPostCreateSerializer(serializers.ModelSerializer):
    """Serializer for creating blog posts."""
    blogTags = serializers.PrimaryKeyRelatedField(
        many=True, queryset=Tags.objects.all(), required=False
    )
    blogCategory = serializers.PrimaryKeyRelatedField(
        queryset=Category.objects.all(), required=False
    )

    class Meta:
        model = BlogPost
        fields = [
            "blogImage", "blogTitle", "blogDescription", "blogExcerpt",
            "blogTags", "blogCategory",
            "metaTitle", "metaDescription",
            "is_featured", "is_published"
        ]

    def create(self, validated_data):
        tags = validated_data.pop("blogTags", [])
        post = BlogPost.objects.create(**validated_data)
        if tags:
            post.blogTags.set(tags)
        return post
