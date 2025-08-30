from django_filters import rest_framework as filters
from .models import Product


class UUIDInFilter(filters.BaseInFilter, filters.UUIDFilter):
    """Custom filter to allow multiple UUIDs (comma-separated or repeated params)."""
    pass


class ProductFilter(filters.FilterSet):
    # Price range
    min_price = filters.NumberFilter(field_name="productPrice", lookup_expr="gte")
    max_price = filters.NumberFilter(field_name="productPrice", lookup_expr="lte")

    # Category filter (multiple UUIDs allowed)
    category = UUIDInFilter(field_name="productCategory__id", lookup_expr="in")

    # In-stock filter
    in_stock = filters.BooleanFilter(method="filter_in_stock")

    # Product name search (partial match, case-insensitive)
    name = filters.CharFilter(field_name="productName", lookup_expr="icontains")

    class Meta:
        model = Product
        fields = ["min_price", "max_price", "category", "in_stock", "name"]

    def filter_in_stock(self, queryset, name, value):
        if value:
            return queryset.filter(productStock__gt=0)
        return queryset
