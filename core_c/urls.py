from django.urls import path
from .views import SupportTicketCreateView

urlpatterns = [
    # POST /api/contact/
    path("contact/", SupportTicketCreateView.as_view(), name="contact-create"),
]
