from django.conf import settings
from django.core.mail import EmailMultiAlternatives
from django.db import transaction
from django.template.loader import render_to_string
from django.utils.html import strip_tags

from rest_framework import generics, permissions, status
from rest_framework.response import Response
from rest_framework.throttling import ScopedRateThrottle

from .models import SupportTicket
from .serializers import (
    SupportTicketCreateSerializer,
    SupportTicketCreatedResponseSerializer,
)


def _get_admin_emails():
    """
    Admin recipients:
      1) SUPPORT_INBOX (list/tuple) in settings, e.g. ("support@doorbix.com",)
      2) Or ADMINS from settings (list of (name, email))
    """
    support_inbox = getattr(settings, "SUPPORT_INBOX", None)
    if support_inbox:
        return list(support_inbox)

    admins = getattr(settings, "ADMINS", [])
    return [email for _, email in admins] or [getattr(settings, "DEFAULT_FROM_EMAIL", "")]


def _send_email(subject: str, to: list[str], html_body: str, from_email: str | None = None):
    """
    Helper to send HTML + text alternative email.
    (Consider moving to Celery task for high volume.)
    """
    from_email = from_email or getattr(settings, "DEFAULT_FROM_EMAIL", "no-reply@localhost")
    text_body = strip_tags(html_body)

    msg = EmailMultiAlternatives(
        subject=subject,
        body=text_body,
        from_email=from_email,
        to=to,
    )
    msg.attach_alternative(html_body, "text/html")
    msg.send(fail_silently=False)


class SupportTicketCreateView(generics.CreateAPIView):
    """
    Public endpoint to create a support ticket from the Contact form.

    Security & Resilience:
      - AllowAny but throttled via ScopedRateThrottle (set DRF DEFAULT_THROTTLE_RATES)
      - Honeypot handled in serializer
      - Transactional creation + email
    """

    permission_classes = [permissions.AllowAny]
    serializer_class = SupportTicketCreateSerializer
    throttle_classes = [ScopedRateThrottle]
    throttle_scope = "contact_form"  # e.g. "10/minute" configured in settings

    def _client_ip(self, request):
        # X-Forwarded-For support behind proxies
        xff = request.META.get("HTTP_X_FORWARDED_FOR")
        if xff:
            return xff.split(",")[0].strip()
        return request.META.get("REMOTE_ADDR")

    @transaction.atomic
    def create(self, request, *args, **kwargs):
        # Bind + validate
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        # Persist
        ticket: SupportTicket = serializer.save(
            ip_address=self._client_ip(request),
            user_agent=request.META.get("HTTP_USER_AGENT", "")[:1024],
        )

        # Compose emails
        admin_recipients = [e for e in _get_admin_emails() if e]
        from_email = getattr(settings, "DEFAULT_FROM_EMAIL", None)

        # Render HTML bodies (use Django templates; fall back to inline HTML if you prefer)
        # You can create templates:
        #   templates/emails/ticket_admin.html
        #   templates/emails/ticket_customer.html
        admin_ctx = {"ticket": ticket}
        customer_ctx = {"ticket": ticket}

        admin_html = render_to_string("email/ticket_admin.html", admin_ctx)
        cust_html = render_to_string("email/ticket_customer.html", customer_ctx)

        # Send emails (sync). For scale, offload to Celery.
        try:
            if admin_recipients:
                _send_email(
                    subject=f"[Support] New ticket {ticket.ticket_no}",
                    to=admin_recipients,
                    html_body=admin_html,
                    from_email=from_email,
                )

            _send_email(
                subject=f"Your support ticket {ticket.ticket_no} has been received",
                to=[ticket.email],
                html_body=cust_html,
                from_email=from_email,
            )
        except Exception:
            # If email fails, we still keep the ticket (don’t roll back user submission)
            # Optionally: log error to Sentry / logging.
            pass

        # Response payload (minimal, safe)
        out = SupportTicketCreatedResponseSerializer(ticket)
        headers = self.get_success_headers(out.data)
        return Response(out.data, status=status.HTTP_201_CREATED, headers=headers)
