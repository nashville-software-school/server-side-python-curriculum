# Firebase Authentication with DRF

## Learning Objectives

* You should be able to determine which routes, and which methods, are needed to enable authentication.

## Connecting FB User to Django Gamer

We are going to handle our Authentication on the Client Side using Firebase. Firebase gives us access to a UID or User ID that is unique to the logged in user. This is the key we will use to connect logged in users to Gamer data. And this is how we will need to connect it all.

1. User logs into the application.
1. Client grabs the UID outside of the user object Firebase gives us.
1. Client checks to see if the user has a row associated with them in the Gamer table using the `/checkuser` route with the UID in the body of the request.

1. If there is no associated Gamer:
    * A empty response gets sent to the client from the `/checkuser` endpoint.
    * A form pops up on the screen for the user to fill out any extra information we need from them. (Ex: bio)
    * After user submits the form, the client sends a request to the server's `/register` route with the user's information in the body of the request.
    * Server extracts all of the information from the request and stores it in Python variables.
    * A record in the `Gamer` table is created.
    * The Gamer data is sent back to the client so that it can be used on future requests to identify the user. This way, the user doesn't have to keep logging in each time a new action is performed.
1. If there is an associated Gamer:
    * Server grabs all the gamer data from the database.
    * The Gamer data is sent back to the client so that it can be used on future requests to identify the user. This way, the user doesn't have to keep logging in each time a new action is performed.

## Check Gamer and Register Functions

Create the following module in your API application. It is commented, so please read the logic once you have it created.

> #### `levelup-server/levelupapi/views/auth.py`

```py
from levelupapi.models import Gamer
from rest_framework.decorators import api_view
from rest_framework.response import Response


@api_view(['POST'])
def check_user(request):
    '''Checks to see if User has Associated Gamer

    Method arguments:
      request -- The full HTTP request object
    '''
    uid = request.data['uid']

    # Use the built-in authenticate method to verify
    # authenticate returns the user object or None if no user is found
    gamer = Gamer.objects.filter(uid=uid).first()

    # If authentication was successful, respond with their token
    if gamer is not None:
        data = {
            'id': gamer.id,
            'uid': gamer.uid,
            'bio': gamer.bio
        }
        return Response(data)
    else:
        # Bad login details were provided. So we can't log the user in.
        data = { 'valid': False }
        return Response(data)


@api_view(['POST'])
def register_user(request):
    '''Handles the creation of a new gamer for authentication

    Method arguments:
      request -- The full HTTP request object
    '''

    # Now save the user info in the levelupapi_gamer table
    gamer = Gamer.objects.create(
        bio=request.data['bio'],
        uid=request.data['uid']
    )

    # Return the gamer info to the client
    data = {
        'id': gamer.id,
        'uid': gamer.uid,
        'bio': gamer.bio
    }
    return Response(data)
```

## Views Package Imports

The `views` directory is going to become a package so that other modules can import the functions. We tell our code it should be a module by adding an `__init__.py` file to the directory.

Create the following file and place the code below in it.

> #### `levelup-server/levelupapi/views/__init__.py`

```py
from .auth import check_user, register_user
```

## Using Views Package to Make Routes

The last step is to establish some URL routes that any client application can use to register and check a gamer to use the API.

Completely replace the contents of the following file with the code below.

> #### `levelup-server/levelup/urls.py`

```py
# ADD THESE Imports
from django.urls import path
from levelupapi.views import register_user, check_user

# ADD THESE LINES TO urlpatterns
urlpatterns = [
    path('register', register_user),
    path('checkuser', check_user),
]
```

In the code above, you will notice that the `register_user` and `check_user` functions are imported into the module. Then they are used to map a route to that view

```py
# Requests to http://localhost:8000/register will be routed to the register_user function
path('register', register_user)
# Requests to http://localhost:8000/checkuser will be routed to the login_user function
path('checkuser', check_user),
```

## Starting the Server

Run the following command in your `levelup-server` directory to start the Django application.

```sh
python manage.py runserver
```
