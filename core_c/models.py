import uuid
import secrets
from django.db import models
from django.utils import timezone


def generate_ticket_no() -> str:
    """
    Human-friendly, unique-ish ticket number.
    Example: DBX-20250828-7F3A9C
    """
    date_str = timezone.now().strftime("%Y%m%d")
    rand = secrets.token_hex(3).upper()  # 6 hex chars
    return f"DBX-{date_str}-{rand}"


class SupportTicket(models.Model):
    """
    Minimal, scalable support ticket model for Contact form submissions.
    """

    class Status(models.TextChoices):
        OPEN = "OPEN", "Open"
        PENDING = "PENDING", "Pending"
        CLOSED = "CLOSED", "Closed"

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)

    # Human-friendly public reference
    ticket_no = models.CharField(
        max_length=32, unique=True, db_index=True, default=generate_ticket_no
    )

    # From the contact form
    name = models.CharField(max_length=120)
    email = models.EmailField(db_index=True)
    message = models.TextField()

    # Optional metadata (useful for abuse control / analytics)
    ip_address = models.GenericIPAddressField(null=True, blank=True)
    user_agent = models.TextField(null=True, blank=True)

    # Workflow
    status = models.CharField(
        max_length=16, choices=Status.choices, default=Status.OPEN, db_index=True
    )
    priority = models.CharField(
        max_length=16,
        choices=[("NORMAL", "Normal"), ("HIGH", "High")],
        default="NORMAL",
        db_index=True,
    )

    # Timestamps
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ("-created_at",)
        indexes = [
            models.Index(fields=["email", "created_at"]),
            models.Index(fields=["status", "priority"]),
        ]

    def __str__(self) -> str:
        return f"{self.ticket_no} — {self.email}"
