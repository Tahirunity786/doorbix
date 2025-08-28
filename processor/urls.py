from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('api/admin/', admin.site.urls),
    path('api/user/', include('core_a.urls')),
    path('api/product/', include('core_p.urls')),
    path('api/blog/', include('core_b.urls')),
    path('api/order/', include('core_o.urls')),
    path('api/contact/', include('core_c.urls')),
]

# Serve media and static files in development

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
