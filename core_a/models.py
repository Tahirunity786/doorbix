
import uuid
from django.contrib.auth.models import AbstractUser
from django.db import models

class CustomUser(AbstractUser):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    password = models.CharField(max_length=128, editable=False)  # won't appear in forms

    def set_password(self, raw_password):
        """
        Override to allow password setting securely.
        """
        super().set_password(raw_password)

    