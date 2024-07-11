# Token Authentication with DRF

## Review of Auth Tokens

Tokens are used by a server and its clients. When the user first registers on the client a unique token is created for that user. The client uses the token in all fetch calls to the server to identify the user making the request.  For your application, when a customer fills out the registration form, the following process occurs:

1. Client sends a request to the server's `/register` route with the user's information in the body of the request.

1. Server extracts all of the information from the request and stores it in Python variables.

1. A record in the `User` table is created.

1. A record in the `Customers` table is created.

1. A new Token is generated for the client by the server. That Token is unique to the user that was just created.

1. The Token is sent back to the client so that it can be used on future requests to identify the user. This way, the user doesn't have to keep filling out their username and password each time a new action is performed.

## Login and Register Functions

For this API, you will be following the strategy from Rock of Ages where the login and register functions are not part of a ViewSet, but just regular functions in the **auth.py** module. Create the following module in your API application. It is commented, so please read the logic once you have it created.

> #### `repairsapi/views/auth.py`

<details>
    <summary>Expand for auth module code</summary>


```py
from django.contrib.auth import authenticate
from django.contrib.auth.models import User
from django.db import IntegrityError
from rest_framework.authtoken.models import Token
from rest_framework import status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from repairsapi.models import Customer, Employee


@api_view(['POST'])
@permission_classes([AllowAny])
def login_user(request):
    '''Handles the authentication of a user

    Method arguments:
      request -- The full HTTP request object
    '''
    email = request.data['email']
    password = request.data['password']

    # Use the built-in authenticate method to verify
    # authenticate returns the user object or None if no user is found
    authenticated_user = authenticate(username=email, password=password)

    # If authentication was successful, respond with their token
    if authenticated_user is not None:
        token = Token.objects.get(user=authenticated_user)

        data = {
            'valid': True,
            'token': token.key,
            'staff': authenticated_user.is_staff
        }
        return Response(data)
    else:
        # Bad login details were provided. So we can't log the user in.
        data = { 'valid': False }
        return Response(data)

@api_view(['POST'])
@permission_classes([AllowAny])
def register_user(request):
    '''Handles the creation of a new user for authentication

    Method arguments:
      request -- The full HTTP request object
    '''
    account_type = request.data.get('account_type', None)
    email = request.data.get('email', None)
    first_name = request.data.get('first_name', None)
    last_name = request.data.get('last_name', None)
    password = request.data.get('password', None)

    if account_type is not None \
        and email is not None\
        and first_name is not None \
        and last_name is not None \
        and password is not None:

        if account_type == 'customer':
            address = request.data.get('address', None)
            if address is None:
                return Response(
                    {'message': 'You must provide an address for a customer'},
                    status=status.HTTP_400_BAD_REQUEST
                )
        elif account_type == 'employee':
            specialty = request.data.get('specialty', None)
            if specialty is None:
                return Response(
                    {'message': 'You must provide a specialty for an employee'},
                    status=status.HTTP_400_BAD_REQUEST
                )
        else:
            return Response(
                {'message': 'Invalid account type. Valid values are \'customer\' or \'employee\''},
                status=status.HTTP_400_BAD_REQUEST
            )

        try:
            # Create a new user by invoking the `create_user` helper method
            # on Django's built-in User model
            new_user = User.objects.create_user(
                username=request.data['email'],
                email=request.data['email'],
                password=request.data['password'],
                first_name=request.data['first_name'],
                last_name=request.data['last_name']
            )
        except IntegrityError:
            return Response(
                {'message': 'An account with that email address already exists'},
                status=status.HTTP_400_BAD_REQUEST
            )

        account = None

        if account_type == 'customer':
            account = Customer.objects.create(
                address=request.data['address'],
                user=new_user
            )
        elif account_type == 'employee':
            new_user.is_staff = True
            new_user.save()

            account = Employee.objects.create(
                specialty=request.data['specialty'],
                user=new_user
            )


        # Use the REST Framework's token generator on the new user account
        token = Token.objects.create(user=account.user)
        # Return the token to the client
        data = { 'token': token.key, 'staff': new_user.is_staff }
        return Response(data)

    return Response({'message': 'You must provide email, password, first_name, last_name and account_type'}, status=status.HTTP_400_BAD_REQUEST)
```
</details>

## Views Package Imports

Import both of those functions into the **views** package.

## Defining Routes

The last step is to establish some URL routes that any client application can use to register and login a customer to use the API.

Completely replace the contents of the following file with the code below.

> #### `repairsproject/urls.py`

```py
from django.contrib import admin
from django.conf.urls import include
from django.urls import path
from repairsapi.views import register_user, login_user

urlpatterns = [
    path('register', register_user),
    path('login', login_user),
    path('admin/', admin.site.urls),
]
```
