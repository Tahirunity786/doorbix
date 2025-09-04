from django.contrib import admin
from .models import Order, OrderAddress, OrderItem, CouriorInfo
# Register your models here.

admin.site.register(CouriorInfo)
admin.site.register(Order)
admin.site.register(OrderAddress)
admin.site.register(OrderItem)
