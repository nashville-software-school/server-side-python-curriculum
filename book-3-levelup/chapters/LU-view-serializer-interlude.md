# Viewsets and Serializers

These are two key terms that you are going to be introduced to in the upcoming chapter. They are the brains of the Django rest operation.

The **ViewSet** has all of the logic for handling an incoming request from a client, determining what action is needed _(i.e. create data, get data, update data, or delete data)_, interacting with the database to do what the client asked, and then constructing a response to the client.

The **Serializer** has a much simpler job. Once the ViewSet has determined what kind of response should be sent to the client, if that response has any data, the Serializer converts the Python data into JSON format.

## Learning Resources

* [Overview of Viewsets](https://www.django-rest-framework.org/api-guide/viewsets/)
* [Model Serializer](https://www.django-rest-framework.org/api-guide/serializers/#modelserializer)

## Anatomy of a View
Here is an example of a Django Rest View. Don’t worry too much about what the code is doing we’ll break down each method in the next chapters. Each model in the database that we want the client to interact with will have its own View. Within that view, there will be methods to handle the different http methods.
- `retrieve` -\> GET requests that have an id in the url, ex: `/animals/1`
- `list` -\> GET requests that will return a list of everything in that table
- `create` -\> POST requests to add a row to that table
- `update` -\> PUT requests to update a row in the table
- `destroy` -\> DELETE requests to delete a row in the table
Each of those methods will use the Django ORM (Object Relational Mapper) to carry out any retrievals or modifications to the database.

```python
class GameTypeView(ViewSet):
    """Level up game types"""

    def retrieve(self, request, pk):
        """Handle GET requests for single game type

        Returns:
            Response -- JSON serialized game type
        """
        game_type = GameType.objects.get(pk=pk)
        serializer = GameTypeSerializer(game_type, context={'request': request})
        return Response(serializer.data)


    def list(self, request):
        """Handle GET requests to get all game types

        Returns:
            Response -- JSON serialized list of game types
        """
        game_types = GameType.objects.all()
        serializer = GameTypeSerializer(
            game_types, many=True, context={'request': request})
        return Response(serializer.data)

    def update(self, request, pk):
        """Handle PUT requests to get all game types

        Returns:
            Response -- 204
        """
        game_type = GameType.objects.get(pk=pk)
        game_type.label = request.data['label']
        game.save()

        return Response({}, status=status.HTTP_204_NO_CONTENT)

    def destroy(self, request, pk):
	"""Handle DELETE requests to get all game types

        Returns:
            Response -- 204
        """
	game_type = GameType.objects.get(pk=pk)
	game_type.delete()

	return Response({}, status=status.HTTP_204_NO_CONTENT)

```

## Anatomy of a Serializer
The View uses the Serializer to convert the data to be sent to the client into json. The Serializer also controls what fields will be sent to the client. Here’s an example of a User Serializer:
```python
class UserSerializer(serializers.ModelSerializer):
    """JSON serializer for the Django user"""
    class Meta:
        model = User
        fields = ('first_name', 'last_name', 'username')
```
The `Meta` class inside the serializer holds the configuration info to use for the serializer. It always needs to know:
- Which model to use
- Which fields to serialize

## Workflow Visualization

Any time that you want to allow a client to access data in your database, there's a series of steps you have to follow in order to accomplish it with Django REST Framework. So far we’ve only written the models. The next step is writing the views and serializers so the client can access and manipulate the data in the database.

![](./images/django-rest-process.png)




