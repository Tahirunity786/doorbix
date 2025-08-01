from django.contrib import admin
from django.urls import path, include  # include is important

urlpatterns = [
    path('api/admin/', admin.site.urls),
    path('api/user/', include('core_a.urls')),  # FIXED
    path('api/product/', include('core_p.urls')),  # FIXED
]
