from rest_framework_simplejwt.tokens import RefreshToken

def create_jwt_token(user):
    """
    Generate JWT tokens for a given user.
    Returns both refresh and access tokens.
    """
    refresh = RefreshToken.for_user(user)
    return {
        "refresh": str(refresh),
        "access": str(refresh.access_token)
    }
