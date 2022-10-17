# Writing the list and retrieve methods

In this chapter we’ll go over creating the initial view files, adding the `list` and `retrieve`, and writing the serializer. After the walkthrough of the `GameTypeView`, you’ll create the `EventView` and `GameView` for practice.

## 1: The GameTypeView Class

Inside the `views` folder create a file named `game_type.py`. Here’s the view skeleton with the imports and methods we’ll add to next:

#### `levelup/levelupapi/views/game_type.py`

```py
"""View module for handling requests about game types"""
from django.http import HttpResponseServerError
from rest_framework.viewsets import ViewSet
from rest_framework.response import Response
from rest_framework import serializers, status
from levelupapi.models import GameType


class GameTypeView(ViewSet):
    """Level up game types view"""

    def retrieve(self, request, pk):
        """Handle GET requests for single game type

        Returns:
            Response -- JSON serialized game type
        """


    def list(self, request):
        """Handle GET requests to get all game types

        Returns:
            Response -- JSON serialized list of game types
        """

```

## 2. Writing the `retrieve` method
The `retrieve` method will get a single object from the database based on the pk (primary key) in the url. We’ll use the ORM to get the data, then the serializer to convert the data to json. Add the following code to the `retrieve`method, making sure the code is tabbed correctly:
```py
game_type = GameType.objects.get(pk=pk)
serializer = GameTypeSerializer(game_type)
return Response(serializer.data)
```

We’re using the `get`method of the ORM to retrieve a single `GameType`. This is equivalent to this sql execute:
```python
db_cursor.execute("""
    select id, label
    from levelupapi_gametype
    where id = ?""",(pk,)
)
```

After getting the `game_type`, it is passed to the serializer. Lastly, the `serializer.data` is passed to the `Response` as the response body. Using `Response` combines what we were doing with the `_set_headers` and `wfile.write` functions.

## 3. Writing the `list` method
The `list` method is responsible for getting the whole collection of objects from the database. The ORM method for this one is `all`. Here’s the code to add to the method:
```python
game_types = GameType.objects.all()
serializer = GameTypeSerializer(game_types, many=True)
return Response(serializer.data)
```

When using the `all`method this is the sql that runs:
```sql
select *
from levelupapi_gametype
```

The `game_types` variable is now a list of `GameType`objects. Just like in the `retrieve`, we’ll pass the `game_types` to the same serializer class. This time adding `many=True` to let the serializer know that a list vs. a single object is to be serialized.

## 4. The Serializer
The serializer class determines how the Python data should be serialized to be sent back to the client. Put the following code at the bottom of the same module as above. Make sure it is outside of the view class.

> #### `levelup/levelupapi/views/game_type.py`

```py
class GameTypeSerializer(serializers.ModelSerializer):
    """JSON serializer for game types
    """
    class Meta:
        model = GameType
        fields = ('id', 'label')
```
The `Meta` class hold the configuration for the serializer. We’re telling the serializer to use the `GameType` model and to include the `id` and`label` fields.

## 5. Adding the URL
So far we’ve set up the view and serializer but not which url to use for the view. We need to add a `/gametypes` resource to the Django application. If a client sends a `GET` request to either `http://localhost:8000/gametypes` or `http://localhost:8000/gametypes/1`, we want the server to respond with the appropriate method. You will use a built-in class in Django Rest called the `DefaultRouter`. The `DefaultRouter` sets up the resource for each method that is present on the view. For now, it will only respond to the `GET` requests to the game type resource.
Add the following import statements at the top of the urls module in the level folder.

> #### `levelup/levelup/urls.py`

```py
from django.conf.urls import include
from rest_framework import routers
from levelupapi.views import GameTypeView
```

In the same file, above the `urlpatterns` add the following:
```py
router = routers.DefaultRouter(trailing_slash=False)
router.register(r'gametypes', GameTypeView, 'gametype')

```
The `trailing_slash=False` tells the router to accept `/gametypes` instead of `/gametypes/`. It’s a very annoying error to come across, when your server is not responding and the code _looks_ right, the only issue is your fetch url is missing a `/` at the end.

The next line is what sets up the `/gametypes` resource. The first parameter, `r'gametypes`, is setting up the url. The second `GameTypeView` is telling the server which view to use when it sees that url. The third, `gametype`, is called the base name. You’ll only see the base name if you get an error in the server. It acts as a nickname for the resource and is usually the singular version of the url.

Last step, once the `router` variable is set, we need to add it to the `urlpatterns`. Anywhere inside the `urlpatterns` list add:
```py
path('', include(router.urls)),
```

## 6. Test it out
Try it out in Postman! To run the server type into a terminal that has the shell running: `./manage.py runserver`
Before running in Postman, add an authorization token to the headers. Here's the token from the fixture chapters to use `fa2eba9be8282d595c997ee5cd49f2ed31f65bed`. Here's how to add the token to the headers:
![](images/postman_token.gif)
* `http://localhost:8000/gametypes` should return a list of all the game types
* `http://localhost:8000/gametypes/1` should return the game type with an id of 1

# Practice
Now repeat steps 1-6 for events and games. By the end you should have an `EventView` and `GameView` with the `list` and `retrieve` methods added. Each view should also have it’s own serializer. When you get to the `urls.py` you’ll only need to add the `router.register` calls to add the `/events` and `/games` resources.


### Try it out

Try adding a game filter to the `EventView`’s `list`. The url will be `http://localhost:8000/events?game=1`. The result should be a list of events with a `game_id` of 1.

