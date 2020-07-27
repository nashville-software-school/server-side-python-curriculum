# ViewSets in Django REST Framework

## Defining the Views Package

Now create a views directory and the file needed to make it a package.

```sh
cd ..
mkdir views
touch views/__init__.py
```

## Park Area View and Serializer

You are going to be using an abstraction in the Django REST Framework library called a `ViewSet`. This particular type allows you to write more abstract code than you did for your first Django exercises and project.

You will also be using another built-in type called a `HyperlinkedModelSerializer`. What this class does is take a Python object and convert it into JSON for you, **and** adds a virtual property of `url` to the resulting JSON.

The `ViewSet` class allows you to write logic for the operations that can be performed on a resource in the API. The first operations you will handle are a client requesting one park area, and a request for all park areas. For these operations, the `ViewSet` exposes `retrieve()` and `list()` methods. Your logic goes in those methods. 

> ##### `kennywoodapi/views/parkarea.py`

```py
"""View module for handling requests about park areas"""
from django.http import HttpResponseServerError
from rest_framework.viewsets import ViewSet
from rest_framework.response import Response
from rest_framework import serializers
from rest_framework import status
from kennywoodapi.models import ParkArea


class ParkAreaSerializer(serializers.HyperlinkedModelSerializer):
    """JSON serializer for park areas

    Arguments:
        serializers.HyperlinkedModelSerializer
    """
    class Meta:
        model = ParkArea
        url = serializers.HyperlinkedIdentityField(
            view_name='parkarea',
            lookup_field='id'
        )
        fields = ('id', 'url', 'name', 'theme')


class ParkAreas(ViewSet):
    """Park Areas for Kennywood Amusement Park"""

    def retrieve(self, request, pk=None):
        """Handle GET requests for single park area

        Returns:
            Response -- JSON serialized park area instance
        """
        try:
            area = ParkArea.objects.get(pk=pk)
            serializer = ParkAreaSerializer(area, context={'request': request})
            return Response(serializer.data)
        except Exception as ex:
            return HttpResponseServerError(ex)
            
    def list(self, request):
        """Handle GET requests to park areas resource

        Returns:
            Response -- JSON serialized list of park areas
        """
        areas = ParkArea.objects.all()
        serializer = ParkAreaSerializer(
            areas,
            many=True,
            context={'request': request}
        )
        return Response(serializer.data)
```

## Django ORM

Wait, wait, wait! What the heck is `ParkArea.objects.all()`????

It's an abstraction that the Object Relational Mapper (ORM) in Django provides that queries the table holding all the park areas, and returns every row. It is the equivalent of you explicitly writing the following SQL.

```sql
SELECT
    pa.id,
    pa.name,
    pa.theme
FROM kennywoodapi_parkarea pa
```

Django will now write that SQL _**for you**_.

## Add View to Package

> ##### `kennywoodapi/views/__init__.py`

```py
from .parkarea import ParkAreas
```

## Create your First Park Area

To see how this all works, you are going to insert a park area into the database manually first. Connect to your Kennywood database and execute the following SQL statement.


```sql
INSERT INTO
    kennywoodapi_parkarea
    ([name], theme)
VALUES
    ('Splashing Safari', 'Water Rides')
;
```

Make sure you commit your changes and then verify that the row was inserted.

Now move on to the next chapter to set up routing and see your first API resource come alive!
