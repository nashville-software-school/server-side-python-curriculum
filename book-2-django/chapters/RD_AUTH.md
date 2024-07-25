# Using a View for Register and Login

In the last project, you used simple Python functions named `register` and `login` in the `auth.py` file. This project will support the same functionality, but that logic will be in a view set in the **views** directory.

> 🧨 There is no functional difference between this mechanism and the mechanism used in Rock of Ages. We are simply showing you two ways of doing the same thing. You may pick either strategy for your capstone.

Create a file in the **views** directory named `users.py`. Then paste the following code into the file.

```py
from rest_framework import viewsets, status, permissions
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import serializers
from rest_framework.authtoken.models import Token

from django.contrib.auth.models import User
from django.contrib.auth import authenticate


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'password', 'first_name', 'last_name']
        extra_kwargs = {'password': {'write_only': True}}


class UserViewSet(viewsets.ViewSet):
    queryset = User.objects.all()
    permission_classes = [permissions.AllowAny]

    @action(detail=False, methods=['post'], url_path='register')
    def register_account(self, request):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            user = User.objects.create_user(
                username=serializer.validated_data['username'],
                username=serializer.validated_data['first_name'],
                username=serializer.validated_data['last_name'],
                password=serializer.validated_data['password']
            )
            token, created = Token.objects.get_or_create(user=user)
            return Response({"token": token.key}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['post'], url_path='login')
    def user_login(self, request):
        username = request.data.get('username')
        password = request.data.get('password')

        user = authenticate(username=username, password=password)

        if user:
            token = Token.objects.get(user=user)
            return Response({'token': token.key}, status=status.HTTP_200_OK)
        else:
            return Response({'error': 'Invalid Credentials'}, status=status.HTTP_400_BAD_REQUEST)
```

## Setting up the Route

1. Import **UserViewSet** into the views package.
2. Remove the entire contents of the `urls.py` module.
3. Replace it with the following code.

```py
from django.contrib import admin
from django.urls import include, path
from rest_framework.routers import DefaultRouter
from digestapi.views import UserViewSet

router = DefaultRouter(trailing_slash=False)

urlpatterns = [
    path('', include(router.urls)),
    path('login', UserViewSet.as_view({'post': 'user_login'}), name='login'),
    path('register', UserViewSet.as_view({'post': 'register_account'}), name='register'),
]
```

## Register

With Postman, perform a POST request to `/register` with the following JSON body.

```json
{
    "username": "meg@ducharme.com",
    "password": "ducharme",
    "first_name": "Meg",
    "last_name": "Ducharme"
}
```

You should received a response with a **201** status code and your token in the response body - which is a series of randomly generated numbers and letters.

```json
{
    "token": "91a91a91a91a91a91a91a91a91a91a"
}
```

Then try to login with those credentials by performing a POST request to `/login` with the following body.

```json
{
    "username": "meg@ducharme.com",
    "password": "ducharme"
}
```

You should receive the exact same token in the response.
