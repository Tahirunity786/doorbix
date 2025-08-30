from django_filters import rest_framework as filters
from .models import Product

class ProductFilter(filters.FilterSet):
    # Price range
    min_price = filters.NumberFilter(field_name="productPrice", lookup_expr="gte")
    max_price = filters.NumberFilter(field_name="productPrice", lookup_expr="lte")

    # Category filters (use ID instead of name)
    category = filters.BaseInFilter(field_name="productCategory__id")  # ✅ single category
    # categories = filters.BaseInFilter(field_name="productCategory__id")  # ✅ multiple categories

    # In-stock filter
    in_stock = filters.BooleanFilter(method="filter_in_stock")

    # Product name search (partial match, case-insensitive)
    name = filters.CharFilter(field_name="productName", lookup_expr="icontains")

    class Meta:
        model = Product
        fields = ["min_price", "max_price", "category", "in_stock", "name"]

    def filter_in_stock(self, queryset, name, value):
        """
        Custom filter: return only products with stock > 0 if in_stock=True.
        """
        if value:
            return queryset.filter(productStock__gt=0)
        return queryset
