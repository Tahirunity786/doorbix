import uuid
from django.db import models
from ckeditor.fields import RichTextField
from django.utils.text import slugify


class Tags(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    name = models.CharField(max_length=100, unique=True, db_index=True)
    slug = models.SlugField(max_length=120, unique=True, blank=True, db_index=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name_plural = "Tags"
        ordering = ["name"]

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name


class Category(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    name = models.CharField(max_length=100, unique=True, db_index=True)
    slug = models.SlugField(max_length=120, unique=True, blank=True, db_index=True)
    description = models.TextField(blank=True, null=True, help_text="Optional description of the category.")
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name_plural = "Categories"
        ordering = ["name"]

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name


class Comments(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    post = models.ForeignKey("BlogPost", on_delete=models.CASCADE, related_name="comments", db_index=True)
    name = models.CharField(max_length=100, db_index=True)
    email = models.EmailField(db_index=True)
    comment = models.TextField()
    comment_on_comment = models.ForeignKey("self", on_delete=models.SET_NULL, null=True, blank=True)
    is_approved = models.BooleanField(default=False, help_text="Only approved comments will be visible publicly.")
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["-created_at"]

    def __str__(self):
        return f"Comment by {self.name} on {self.post}"


class BlogPost(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    blogImage = models.ImageField(upload_to="blogs_upload/", null=True, blank=True)
    blogTitle = models.CharField(max_length=200, db_index=True)
    slug = models.SlugField(max_length=220, unique=True, blank=True, db_index=True)
    blogDescription = RichTextField()
    blogExcerpt = models.TextField(max_length=500, blank=True, help_text="Short summary for previews & SEO.")
    blogTags = models.ManyToManyField(Tags, related_name="blog_posts", blank=True)
    blogCategory = models.ForeignKey(Category, on_delete=models.SET_NULL, null=True, related_name="posts")
    
    metaTitle = models.CharField(max_length=255, blank=True, help_text="SEO meta title.")
    metaDescription = models.CharField(max_length=300, blank=True, help_text="SEO meta description.")

    is_featured = models.BooleanField(default=False)
    is_published = models.BooleanField(default=False)
    views_count = models.PositiveIntegerField(default=0)
    
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ["-created_at"]

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.blogTitle)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.blogTitle
