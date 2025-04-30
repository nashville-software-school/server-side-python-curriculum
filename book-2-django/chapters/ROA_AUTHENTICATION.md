# Token Authentication with DRF

## Understanding Auth Tokens

Tokens are used by a server and its clients. When the user first registers on the client a unique token is created for that user. The client uses the token in all fetch calls to the server to identify the user making the request.  For your application, when a user fills out the registration form, the following process occurs:

1. Client sends a request to the server's `/register` route with the user's information in the body of the request.

1. Server extracts all of the information from the request and stores it in Python variables.

1. A record in the `auth_user` table is created.

1. A record in the `authtoken_token` table is created with a foriegn key to the data created in the last step.

1. The Token is sent back to the client so that it can be used on future requests to identify the user. This way, the user doesn't have to keep filling out their username and password each time a new action is performed.

## Login and Register Functions

The following module is already set up for you in your API application. You can review the code if you like, but authenticate is not a core learning objective here at NSS, so we just give you the code.

> #### `rockapi/views/auth.py`

## Enable Login and Register Requests

Lastly, the **register_user** and **login_user** functions are imported into the the `urls.py` module and mapped to a specific route that a client can make a request to. This code is already provided in the starter code you have.

```py
from django.contrib import admin
from django.urls import include, path
from rest_framework import routers
from rockapi.views import register_user, login_user

router = routers.DefaultRouter(trailing_slash=False) # Not used yet

urlpatterns = [
    path('', include(router.urls)),
    path('register', register_user), # Enables http://localhost:8000/register
    path('login', login_user), # Enables http://localhost:8000/login
]
```

## Register

With Yaak, perform a POST request to `/register` with the following JSON body.

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

