from datetime import timedelta
import os
from celery import Celery
from kombu import Queue
from celery.schedules import crontab  # ✅ Required for scheduling tasks

# Set the default Django settings module
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "processor.settings")

# Create an instance of the Celery application
app = Celery("processor")

# Load task-related settings with the prefix 'CELERY_'
app.config_from_object("django.conf:settings", namespace="CELERY")

# Define priority queues properly
app.conf.task_queues = (
    Queue("high_priority"),
    Queue("default"),
)

# Set default queue
app.conf.task_default_queue = "default"

# # Route specific tasks to high-priority queue
# app.conf.task_routes = {
#     "core_o.tasks.email_agent": {"queue": "high_priority"},
# }

# Runs once a day at midnight (00:00)
# app.conf.beat_schedule = {
#     'email-campaign-daily': {
#         'task': "core_o.tasks.email_agent",
#         'schedule': crontab(hour=0, minute=0),  # ✅ once per day at 00:00
#     },
# }
app.conf.beat_schedule = {
    'email-campaign-every-minute': {
        'task': "core_o.tasks.email_agent",
        'schedule': timedelta(minutes=60),  # 🔄 run every 1 minute
    },
}
# Auto-discover tasks
app.autodiscover_tasks()
