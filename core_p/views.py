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

User = get_user_model()

class ProductViewSet(viewsets.ViewSet):
    PRODUCT_TYPE_FILTERS = {
        'bestSelling': {'productIsBestSelling': True},
        'featuredProducts': {'productIsFeatured': True},
        'onSaleProducts': {'productIsOnSale': True},
        'subscriptionProduct': {'productIsForSubscription': True},
        'discountProduct': {'productIsDiscounted': True},
    }

    def list(self, request):
        product_type = request.query_params.get('type')
        product_quantity = request.query_params.get('quantity')
        allow_collection = request.query_params.get('collection')
        all_category = request.query_params.get('category')=="true"

        cache_key = f"products:list:type={product_type}&quantity={product_quantity}&collection={allow_collection}"
        cached_data = cache.get(cache_key)
        if cached_data:
            return Response(cached_data)

        queryset = Product.objects.all()

        if product_type in self.PRODUCT_TYPE_FILTERS:
            queryset = queryset.filter(
                **self.PRODUCT_TYPE_FILTERS[product_type],
                productIsActive="published"
            ).order_by('-productCreatedAt')

        if product_quantity:
            quantity = self._parse_int(product_quantity, "quantity")
            if quantity is None:
                return Response({'error': 'Invalid quantity. Must be an integer.'}, status=400)
            queryset = queryset[:quantity]

        data = MiniProductSerializer(queryset, many=True).data

        if allow_collection:
            collection_quantity = self._parse_int(allow_collection, "collection quantity")
            if collection_quantity is None:
                return Response({'error': 'Invalid collection quantity. Must be an integer.'}, status=400)
            collections = ProductCollection.objects.all()[:collection_quantity]

            data = {
                "products": data,
                "collections": MiniCollectionSerializer(collections, many=True).data
            }
        
        if all_category:
            categories = ProductCategory.objects.all().order_by('-created_at')
            data['categories'] = ProductCategorySerializer(categories, many=True).data
            

        cache.set(cache_key, data, timeout=300)
        return Response(data)

    def retrieve(self, request, pk=None):
        """
        Retrieve product by either UUID or slug.
        Supports caching for performance.
        Allows returning full or mini data via ?view=mini|full
        """
        identifier = iri_to_uri(pk)
        view_type = request.query_params.get("view", "full")  # default is full
    
        # Cache key depends on identifier + view type
        cache_key = f"products:detail:{identifier}:{view_type}"
        cached_data = cache.get(cache_key)
        if cached_data:
            return Response(cached_data, status=status.HTTP_200_OK)
    
        # Try to detect if pk is a UUID
        try:
            uuid_obj = UUID(str(identifier))
            filter_kwargs = {"id": uuid_obj}
        except (ValueError, TypeError):
            filter_kwargs = {"productSlug": identifier}
    
        # Fetch product
        product = get_object_or_404(Product, **filter_kwargs)
    
        # Choose serializer depending on view type
        if view_type == "mini":
            data = {
                "id": str(product.id),   # UUID string
                "slug": product.productSlug,
                "name": product.productName,
                "price": product.productPrice,
                "image": (
                    request.build_absolute_uri(product.productImages.first().image.url)
                    if product.productImages.exists() and product.productImages.first().image
                    else None
                ),
                "qty": 1,  # default quantity for cart/cart-like usage
            }
        else:
            data = ProductSerializer(product).data  # serializer.data
    
        # Cache data for 5 minutes
        cache.set(cache_key, data, timeout=300)
    
        return Response(data, status=status.HTTP_200_OK)



    def _parse_int(self, value, field_name):
        try:
            return int(value)
        except ValueError:
            return None



class CollectionViewset(viewsets.ViewSet):

    def list(self, request):
        product_quantity = request.query_params.get('quantity')
        cache_key = f"collections:{product_quantity or 'list'}"

        # Return cached data if available
        if cached_data := cache.get(cache_key):
            return Response(cached_data, status=status.HTTP_200_OK)

        try:
            collections = ProductCollection.objects.all()

            if product_quantity:
                try:
                    quantity = int(product_quantity)
                    collections = collections[:quantity]
                except ValueError:
                    return Response(
                        {"error": "Invalid quantity. Must be an integer."},
                        status=status.HTTP_400_BAD_REQUEST,
                    )

            serializer = MiniCollectionSerializer(collections, many=True)
            data = serializer.data

            # Cache for 5 minutes
            cache.set(cache_key, data, timeout=300)

            return Response(data, status=status.HTTP_200_OK)

        except Exception as e:
            return Response(
                {"error": str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )

    def retrieve(self, request, pk=None):
        slug = iri_to_uri(pk)
        cache_key = f"collections:detail:{slug}"
        cached_data = cache.get(cache_key)

        if cached_data:
            return Response(cached_data, status=status.HTTP_200_OK)

        try:
            collection = get_object_or_404(ProductCollection, collectionSlug=slug)
            serializer = ProductCollectionSerializer(collection)
            data = serializer.data
            cache.set(cache_key, data, timeout=300)
            return Response(data, status=status.HTTP_200_OK)
        except Exception as e:
            return Response(
                {"error": "Something went wrong", "details": str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )



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