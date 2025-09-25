from uuid import UUID
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework import viewsets, status, generics, filters
from django.utils import timezone
from django.shortcuts import get_object_or_404
from django.core.cache import cache
from django.utils.encoding import iri_to_uri
from django_filters.rest_framework import DjangoFilterBackend
from django.db.models import F, Value, FloatField, Q, When, Case, IntegerField
from django.db.models.expressions import RawSQL

from django.contrib.auth import get_user_model
from .filter import ProductFilter, normalize_query

from .models import CouponUsage, Product, ProductCategory, ProductCollection, Coupon
from .serializer import CouponSerializer, ProductCategorySerializer, ProductSerializer, MiniProductSerializer, ProductCollectionSerializer, MiniCollectionSerializer
from rest_framework.pagination import PageNumberPagination


User = get_user_model()



class SmallPagination(PageNumberPagination):
    page_size = 20
    page_size_query_param = "page_size"
    max_page_size = 100

class ProductViewSet(viewsets.ViewSet):
    PRODUCT_TYPE_FILTERS = {
        "bestSelling": {"productIsBestSelling": True},
        "featuredProducts": {"productIsFeatured": True},
        "onSaleProducts": {"productIsOnSale": True},
        "subscriptionProduct": {"productIsForSubscription": True},
        "discountProduct": {"productIsOnSale": True},  # same as onSaleProducts
    }

    def list(self, request):
        params = request.query_params
        product_type = params.get("type")
        product_quantity = params.get("quantity")
        allow_collection = params.get("collection")
        all_category = params.get("category") == "true"

        # 🔑 Cache key
        cache_key = f"products:list:{product_type}:{product_quantity}:{allow_collection}:{all_category}"
        cached_data = cache.get(cache_key)
        if cached_data:
            return Response(cached_data)

        # ✅ Base queryset with optimized prefetch/select
        queryset = (
            Product.objects.filter(productIsActive="published")
            .select_related("productVariant", "productShipping", "productSeo")
            .prefetch_related("productImages", "productCollection", "productCategory", "productTags")
            .order_by("-productCreatedAt")
        )

        # ✅ Apply product type filter if valid
        if product_type in self.PRODUCT_TYPE_FILTERS:
            queryset = queryset.filter(**self.PRODUCT_TYPE_FILTERS[product_type])

        # ✅ Products (quantity or pagination)
        if product_quantity:
            try:
                quantity = int(product_quantity)
                queryset = queryset[:quantity]
            except ValueError:
                return Response({"error": "Invalid quantity. Must be an integer."}, status=400)

            products_data = MiniProductSerializer(queryset, many=True).data

        elif product_type in self.PRODUCT_TYPE_FILTERS:
            # MiniProduct types → full list without pagination
            products_data = MiniProductSerializer(queryset, many=True).data

        else:
            # Other types → paginated
            paginator = SmallPagination()
            page = paginator.paginate_queryset(queryset, request)
            products_data = MiniProductSerializer(page, many=True).data
            return paginator.get_paginated_response({"products": products_data})

        # ✅ Build response
        response_data = {"products": products_data}

        # ✅ Add collections if requested
        if allow_collection:
            try:
                c_qty = int(allow_collection)
                collections = ProductCollection.objects.all().order_by("-created_at")[:c_qty]
                response_data["collections"] = MiniCollectionSerializer(collections, many=True).data
            except ValueError:
                return Response({"error": "Invalid collection quantity. Must be an integer."}, status=400)

        # ✅ Add categories if requested
        if all_category:
            categories = ProductCategory.objects.all().order_by("-created_at")
            response_data["categories"] = ProductCategorySerializer(categories, many=True).data

        # ✅ Cache final response (5 minutes)
        cache.set(cache_key, response_data, timeout=300)
        return Response(response_data)

    def retrieve(self, request, pk=None):
        identifier = iri_to_uri(pk)
        view_type = request.query_params.get("view", "full").lower().strip()
        vid = request.query_params.get("variant")

        cache_key = self.make_cache_key(identifier, view_type, vid)
        if (cached := cache.get(cache_key)):
            return Response(cached, status=status.HTTP_200_OK)

        # ✅ Detect UUID vs slug
        try:
            filter_kwargs = {"id": UUID(str(identifier))}
        except (ValueError, TypeError):
            filter_kwargs = {"productSlug": identifier}

        product = get_object_or_404(
            Product.objects.select_related("productVariant", "productShipping", "productSeo")
            .prefetch_related("productImages", "productCollection", "productCategory", "productTags"),
            **filter_kwargs
        )

        # ✅ Mini view builder
        def build_mini_data(prod, variant=None):
            img = None
            if variant and variant.valueImage:
                img = request.build_absolute_uri(variant.valueImage.url)
            elif prod.productImages.exists():
                first_img = prod.productImages.first()
                if first_img and first_img.image:
                    img = request.build_absolute_uri(first_img.image.url)
        
            return {
                "id": str(prod.id),
                "slug": prod.productSlug,
                "name": prod.productName,
                "price": float((variant and variant.valuePrice) or prod.productPrice),
                "image": img,
                "qty": 1,
                "variant": (
                    {
                        "id": str(variant.id),
                        "name": variant.valueName,
                        "code": variant.colorCode,
                        "sku": variant.valueSKU,
                        "price": float(variant.valuePrice or 0),
                        "image": request.build_absolute_uri(variant.valueImage.url) if variant.valueImage else None,
                    }
                    if variant else None
                ),
            }


        # ✅ Variant mini view
        if view_type == "mini":
            variant_value = None
            if vid:
                variant_value = getattr(product.productVariant, "variantValue", None)
                variant_value = variant_value.filter(id=vid).first() if variant_value else None
            data = build_mini_data(product, variant_value)
        else:
            data = ProductSerializer(product).data

        cache.set(cache_key, data, timeout=300)
        return Response(data, status=status.HTTP_200_OK)

    @staticmethod
    def make_cache_key(identifier: str, view_type: str, vid: str | None = None) -> str:
        return ":".join(["products:detail", f"id={identifier}", f"view={view_type}", f"variant={vid}" if vid else ""])



class CollectionViewset(viewsets.ViewSet):
    """
    Optimized ViewSet for Product Collections.
    - Uses caching for list & detail.
    - Handles quantity param safely.
    - Minimizes DB load with `only()`.
    """

    CACHE_TIMEOUT = 300  # 5 minutes

    def list(self, request):
        product_quantity = request.query_params.get("quantity")

        # build cache key
        cache_key = f"collections:list:{product_quantity or 'all'}"
        if cached := cache.get(cache_key):
            return Response(cached, status=status.HTTP_200_OK)

        # validate quantity
        quantity = None
        if product_quantity:
            if not product_quantity.isdigit():
                return Response(
                    {"error": "Invalid quantity. Must be an integer."},
                    status=status.HTTP_400_BAD_REQUEST,
                )
            quantity = int(product_quantity)

        # optimized queryset (load only required fields for MiniCollectionSerializer)
        queryset = ProductCollection.objects.only("id", "collectionName", "collectionSlug").order_by("-created_at")
        if quantity:
            queryset = queryset[:quantity]

        serializer = MiniCollectionSerializer(queryset, many=True)
        data = {"collections": serializer.data}

        cache.set(cache_key, data, timeout=self.CACHE_TIMEOUT)
        return Response(data, status=status.HTTP_200_OK)

    def retrieve(self, request, pk=None):
        slug = iri_to_uri(pk)
        cache_key = f"collections:detail:{slug}"

        if cached := cache.get(cache_key):
            return Response(cached, status=status.HTTP_200_OK)

        collection = get_object_or_404(
            ProductCollection.objects.select_related(), collectionSlug=slug
        )
        serializer = ProductCollectionSerializer(collection)
        data = serializer.data

        cache.set(cache_key, data, timeout=self.CACHE_TIMEOUT)
        return Response(data, status=status.HTTP_200_OK)

# -------------------------------
# SearchProduct API View
# -------------------------------


class SearchProduct(generics.ListAPIView):
    serializer_class = MiniProductSerializer
    filter_backends = [DjangoFilterBackend, filters.OrderingFilter]
    filterset_class = ProductFilter
    ordering_fields = ["productName", "productPrice", "productCreatedAt"]
    ordering = ["-productCreatedAt"]

    def _make_cache_key(self, params):
        # deterministic key from sorted params
        items = "&".join(f"{k}={v}" for k, v in sorted(params.items()))
        return f"products:{items}"

    def get_queryset(self):
        params = self.request.query_params.dict()
        search_raw = (self.request.query_params.get("search") or "").strip()
        if not search_raw:
            return Product.objects.filter(productIsActive="published")

        parsed = normalize_query(search_raw)
        numbers = parsed["numbers"]
        tokens = parsed["tokens"]

        base_qs = Product.objects.filter(productIsActive="published") \
            .select_related("productVariant") \
            .prefetch_related("productCategory", "productTags", "productImages")

        # cache_key = "search:" + "&".join(f"{k}={v}" for k, v in sorted(self.request.query_params.items()))
        # cached_ids = cache.get(cache_key)
        # if cached_ids:
        #     preserved_order = Case(*[When(id=pk, then=pos) for pos, pk in enumerate(cached_ids)],
        #                            default=Value(len(cached_ids)), output_field=IntegerField())
        #     return Product.objects.filter(id__in=cached_ids).annotate(_order=preserved_order).order_by("_order")

        # 1) Fulltext MATCH...AGAINST (natural or boolean mode)
        match_sql = "MATCH(`productName`,`productDescription`) AGAINST (%s IN NATURAL LANGUAGE MODE)"
        ft_qs = base_qs.annotate(ft_score=RawSQL(match_sql, (search_raw,))).filter(ft_score__gt=0).order_by("-ft_score")
        ft_ids = list(ft_qs.values_list("id", flat=True))

        # 2) If numbers detected, also try numeric matches (ids, price, sku, etc.)
        numeric_ids = []
        if numbers:
            for n in numbers:
                try:
                    if '.' in n:
                        val = float(n)
                        numeric_ids.extend(list(base_qs.filter(productPrice=val).values_list('id', flat=True)))
                    else:
                        val = int(n)
                        numeric_ids.extend(list(base_qs.filter(Q(id=val) | Q(productStock=val)).values_list('id', flat=True)))
                except ValueError:
                    continue

        # 3) Fallback: icontains across fields for tokens (gets punctuation-backed tokens too)
        needed = 200
        gathered = []
        gathered.extend(ft_ids)
        gathered.extend(x for x in numeric_ids if x not in gathered)

        if len(gathered) < needed:
            # build icontains Q
            q_filters = Q()
            for t in tokens:
                q_filters |= Q(productName__icontains=t) | Q(productDescription__icontains=t) | Q(productCategory__categoryName__icontains=t)
            fallback_ids = list(base_qs.filter(q_filters).exclude(id__in=gathered).values_list("id", flat=True)[: needed - len(gathered)])
            gathered.extend(fallback_ids)

        if not gathered:
            return base_qs.none()

        preserved_order = Case(*[When(id=pk, then=pos) for pos, pk in enumerate(gathered)],
                               default=Value(len(gathered)), output_field=IntegerField())
        qs = Product.objects.filter(id__in=gathered).annotate(_order=preserved_order).order_by("_order")

        # cache.set(cache_key, gathered, timeout=120)
        return qs

class CouponApplier(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        serializer = CouponSerializer(data=request.data)
        if not serializer.is_valid():
            return Response({
                "status": "error",
                "message": "Oops! Something’s wrong with the email you entered.",
                "errors": serializer.errors
            }, status=status.HTTP_400_BAD_REQUEST)

        code = serializer.validated_data['code']

        try:
            # Filter valid coupons
            coupon = Coupon.objects.filter(
                code__iexact=code,
                active=True,
                expires_at__gt=timezone.now()
            ).first()  # get coupon or None

            if not coupon:
                return Response({
                    "status": "warning",
                    "message": "Hmm… Invalid Coupon 😅"
                }, status=status.HTTP_404_NOT_FOUND)

            # Check usage
            usage = CouponUsage.objects.filter(coupon=coupon, user=request.user).first()
            usage_count = usage.usage_count if usage else 0

            if coupon.usage_limit and usage_count >= coupon.usage_limit:
                return Response({
                    "status": "warning",
                    "message": f"Oops! You have already used this coupon {coupon.usage_limit} times."
                }, status=status.HTTP_400_BAD_REQUEST)

            # Success response
            coupon_data = {
                "id": str(coupon.id),
                "code": coupon.code,
                "discount_type": getattr(coupon, "discount_type", "percentage"),
                "discount_value": float(getattr(coupon, "discount_value", coupon.discount_percentage)),
                "usage_limit": coupon.usage_limit,
                "expiry_date": coupon.expires_at,
            }

            return Response({
                "status": "success",
                "message": f"Yay! Your coupon '{coupon.code}' has been applied successfully. 🎉",
                "data": coupon_data
            }, status=status.HTTP_200_OK)

        except Exception as e:
            return Response({
                "status": "error",
                "message": "Oops! Something went wrong while applying the coupon. Please try again later.",
                "details": str(e)
            }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)