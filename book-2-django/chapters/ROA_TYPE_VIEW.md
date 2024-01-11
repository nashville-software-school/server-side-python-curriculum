# Getting All Rock Types

You will be creating a _View_ in this chapter. In Django, the _View_ handles the request from the client, does the work to get the requested data, and sends a response back to the client.

## Type View

Inside the `views` folder create a file named `type_view.py`. Here’s the view skeleton with the imports and methods we’ll add to next:

#### `rockproject/rockapi/views/type_view.py`

```py
"""View module for handling requests for type data"""
from django.http import HttpResponseServerError
from rest_framework.viewsets import ViewSet
from rest_framework.response import Response
from rest_framework import serializers, status
from rockapi.models import Type


class TypeView(ViewSet):
    """Rock API types view"""

    def list(self, request):
        """Handle GET requests to get all types

        Returns:
            Response -- JSON serialized list of types
        """

        types = Type.objects.all()
        serialized = TypeSerializer(types, many=True)
        return Response(serialized.data, status=status.HTTP_200_OK)

    def retrieve(self, request, pk=None):
        """Handle GET requests for single type

        Returns:
            Response -- JSON serialized type record
        """

        rock_type = Type.objects.get(pk=pk)
        serialized = TypeSerializer(rock_type)
        return Response(serialized.data, status=status.HTTP_200_OK)


class TypeSerializer(serializers.ModelSerializer):
    """JSON serializer for types"""
    class Meta:
        model = Type
        fields = ('id', 'label', )
```

## Add View to Package

#### `rockproject/rockapi/views/__init__.py`

```py
from .type_view import TypeView
```

## Adding the URL

So far we’ve set up the view and serializer but not which URL to use for the view. We need to add `/types` to be supported by the API.

If a client sends a `GET` request to either `http://localhost:8000/types` or `http://localhost:8000/types/1`, we want the server to respond with the appropriate method.

You will use a built-in class in Django REST called the `DefaultRouter`. The `DefaultRouter` sets up the resource for each method that is present on the view.

> #### `rockproject/rockproject/urls.py`

Add the following import statements at the top of the `urls.py` module.

```py
from django.conf.urls import include
from rest_framework import routers
from rockapi.views import TypeView
```

In the same file, above the current `urlpatterns` variable, add the following:

```py
router = routers.DefaultRouter(trailing_slash=False)
router.register(r'types', TypeView, 'type')
```
The `trailing_slash=False` tells the router to accept `/types` instead of `/types/`. It’s a very annoying error to come across, when your server is not responding and the code _looks_ right, the only issue is your fetch url is missing a `/` at the end.

The next line is what sets up the `/types` resource. The first parameter, `r'types`, is setting up the URL. The second `TypeView` is telling the server which view to use when it sees that url.

The third, `type`, is called the base name. You’ll only see the base name if you get an error in the server. It acts as a nickname for the resource and is usually the singular version of the URL.

## Video Walkthrough

Here is a 5:55 minute walkthrough of implementing the code with explanations.

[<img src="./images/video-play-icon.gif" height="75rem" />](https://watch.screencastify.com/v/UkVfmoThqRW3tgxHpVqP)

## Test Your View

Try it out in your API client!

1. Open the `authtoken_token` table in your database and examine the `pk` key on each object. These are unique tokens assigned to every user in the system.
2. Copy any one of them to use in your API client.
3. Start a new GET request.
4. Add a new header to the request named `Authorization`
5. Grab a token from your `authtoken_tokens` table.
6. The value will be the word Token, followed by a space, and then the unique token you copied
7. Then grab one of the following two URLs and send a request.
   - `http://localhost:8000/types` should return a list of all the types.
   - `http://localhost:8000/types/1` should return the type with an id of 1.
