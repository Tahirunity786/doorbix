from django.contrib import admin
from .models import *
# Register your models here.

admin.site.register(BlogPost)
admin.site.register(Tags)
admin.site.register(Comments)
admin.site.register(Category)