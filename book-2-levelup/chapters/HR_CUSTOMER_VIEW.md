# Getting All Customers from the API

You will be creating a _View_ in this chapter. In Django, the _View_ handles the request from the client, does the work to get the requested data, and sends a response back to the client.

## Customer View

Inside the `views` folder create a file named `customer_view.py`. Here’s the view skeleton with the imports and methods we’ll add to next:

#### `honey-rae-server/repairsapi/views/customer_view.py`

```py
"""View module for handling requests for customer data"""
from django.http import HttpResponseServerError
from rest_framework.viewsets import ViewSet
from rest_framework.response import Response
from rest_framework import serializers, status
from repairsapi.models import Customer


class CustomerView(ViewSet):
    """Honey Rae API customers view"""

    def list(self, request):
        """Handle GET requests to get all customers

        Returns:
            Response -- JSON serialized list of customers
        """

        # Step 1: Get all customer data from the database
        customers = Customer.objects.all()

        # Step 2: Convert the data to JSON format
        serialized = CustomerSerializer(customers, context={'request': request})

        # Step 3: Respond to the client with the JSON data and 200 status code
        return Response(serialized.data, status=status.HTTP_200_OK)


class CustomerSerializer(serializers.ModelSerializer):
    """JSON serializer for customers"""
    class Meta:
        model = Customer
        fields = ('id', 'user', 'address')
```

## Add View to Package

#### `honey-rae-server/repairsapi/views/__init__.py`

```py
from .customer_view import CustomerView
```

## Adding the URL

So far we’ve set up the view and serializer but not which url to use for the view. We need to add a `/gametypes` resource to the Django application. If a client sends a `GET` request to either `http://localhost:8000/gametypes` or `http://localhost:8000/gametypes/1`, we want the server to respond with the appropriate method. You will use a built-in class in Django Rest called the `DefaultRouter`. The `DefaultRouter` sets up the resource for each method that is present on the view. For now, it will only respond to the `GET` requests to the game type resource.

> #### `honey-rae-server/honeyrae/urls.py`

Add the following import statements at the top of the `urls.py` module.

```py
from rest_framework import routers
from repairsapi.views import CustomerView
```

In the same file, above the current `urlpatterns` variable, add the following:

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
`http://localhost:8000/gametypes` should return a list of all the game types
`http://localhost:8000/gametypes/1` should return the game type with an id of 1

# Practice
Now repeat steps 1-6 for events and games. By the end you should have an `EventView` and `GameView` with the `list` and `retrieve` methods added. Each view should also have it’s own serializer. When you get to the `urls.py` you’ll only need to add the `router.register` calls to add the `/events` and `/games` resources.

# (Optional) Bonus
The code we have so far works great but there are a few changes we could add to make it even better.

## Adding filters the `list` methods
Right now the list methods just returns everything from the table. What if we wanted to pass in a query string parameter? Let’s take a look at the `GameView`’s `list` method and make a change there. Before sending the `games` list to the serializer, let’s check to see if a query string parameter has been passed to the url. For this example, we’ll say we want a way to filter by the game type.

The url from the client will look like`http://localhost:8000/games?type=1`. There’s no need to parse the url here because the `ViewSet` class that the `GameView` is inheriting from has done that for us:
```py
games = Game.objects.all()

# Add in the next 3 lines
game_type = request.query_params.get('type', None)
if game_type is not None:
    games = games.filter(game_type_id=game_type)

serializer = GameSerializer(games, many=True)
return Response(serializer.data)
```
The `request` from the method parameters holds all the information for the request from the client. The `request.query_params` is a dictionary of any query parameters that were in the url. Using the `.get` method on a dictionary is a safe way to find if a key is present on the dictionary. If the `'type'` key is not present on the dictionary it will return `None`.

After getting a value for `game_type`, we can use the ORM `filter` method to only include games with that game type. This is the equivalent of this command:
```py
db_cursor.execute("""
    select *
    from levelupapi_game
    where game_type_id = ?
""", (game_type,))
```

Since we’re just overwriting the value of the `games` variable nothing else in the function needs to change.

Try it out in Postman: `http://localhost:8000/games?type=1` If you get back empty array, make sure you have a game with a `game_type_id` of 1.

### Try it out
Try adding a game filter to the `EventView`’s `list`. The url will be `http://localhost:8000/events?game=1`. The result should be a list of events with a `game_id` of 1.

## Add a try/except block to the `retrieve` methods
What happens if you try to get a game type that doesn’t exist? Try `http://localhost:8000/gametypes/100` What error comes up in the postman response? It’s a pretty ugly error that isn’t very useful.

We can change that by adding a try/except block around the `GameType.obejcts.get` method call. Update the retrieval method with this code:
```py
try:
    game_type = GameType.objects.get(pk=pk)
    serializer = GameTypeSerializer(game_type)
    return Response(serializer.data)
except GameType.DoesNotExist as ex:
    return Response({'message': ex.args[0]}, status=status.HTTP_404_NOT_FOUND)
```

With this change, if the code inside the try block throws a `DoesNotExist` then the server will respond with a nicer 404 message. Try to get a game type that doesn’t exist again to see the difference.

### Try it out
Add the try/except block to the other `retrieve` methods

## Adding a `depth` to the serializers
Right now the `GET` methods do not include any nested data, only the foreign key. Embedding that data is only 1 line of code! Take a look at the response for getting all the games. Notice that `game_type` is just the id of the type. Back in the `GameSerializer` add this to the end of `Meta` class tabbed to the same level as the `fields` property
```py
depth = 1
```
And that’s it! Back in postman, get all the games again to see the difference

### Try it out
Add the depth to the `EventSerializer`. What happens if you set the depth equal to 2?
