# Authentication in Django REST Framework

In this chapter, you will be updating your API application to enable authentication of a client application so it can track users.

## Update Application Settings

First, open your `settings.py` and update the default permission class in your `REST_FRAMEWORK` settings.

```yml
'DEFAULT_PERMISSION_CLASSES': [
    'rest_framework.permissions.IsAuthenticatedOrReadOnly',
],
```

## Register and Login

Create a `views/register.py` module and place the following code in it.

```py
import json
from django.http import HttpResponse
from django.contrib.auth import login, authenticate
from django.contrib.auth.models import User
from rest_framework.authtoken.models import Token
from django.views.decorators.csrf import csrf_exempt
from kennywoodapi.models import Customer


@csrf_exempt
def login_user(request):
    '''Handles the authentication of a user

    Method arguments:
      request -- The full HTTP request object
    '''

    req_body = json.loads(request.body.decode())

    # If the request is a HTTP POST, try to pull out the relevant information.
    if request.method == 'POST':

        # Use the built-in authenticate method to verify
        username = req_body['username']
        password = req_body['password']
        authenticated_user = authenticate(username=username, password=password)

        # If authentication was successful, respond with their token
        if authenticated_user is not None:
            token = Token.objects.get(user=authenticated_user)
            data = json.dumps({"valid": True, "token": token.key})
            return HttpResponse(data, content_type='application/json')

        else:
            # Bad login details were provided. So we can't log the user in.
            data = json.dumps({"valid": False})
            return HttpResponse(data, content_type='application/json')


@csrf_exempt
def register_user(request):
    '''Handles the creation of a new user for authentication

    Method arguments:
      request -- The full HTTP request object
    '''

    # Load the JSON string of the request body into a dict
    req_body = json.loads(request.body.decode())

    # Create a new user by invoking the `create_user` helper method
    # on Django's built-in User model
    new_user = User.objects.create_user(
        username=req_body['username'],
        email=req_body['email'],
        password=req_body['password'],
        first_name=req_body['first_name'],
        last_name=req_body['last_name']
    )

    customer = Customer.objects.create(
        family_members=req_body['family_members'],
        user=new_user
    )

    # Commit the user to the database by saving it
    customer.save()

    # Use the REST Framework's token generator on the new user account
    token = Token.objects.create(user=new_user)

    # Return the token to the client
    data = json.dumps({"token": token.key})
    return HttpResponse(data, content_type='application/json')
```

Add your new functions to the package in `kennywoodapi/views/__init__.py`.

```py
from .register import register_user
from .register import login_user
```

Then import those views into `kennywood/urls.py`.

```py
from kennywoodapi.views import register_user, login_user
```

Then set up those new routes to map to `/register`, and `/login`.

```py
urlpatterns = [
    path('', include(router.urls)),
    path('register/', register_user),
    path('login/', login_user),
    path('api-token-auth/', obtain_auth_token),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
]
```
