# Joining an Event
Right now, there’s no method for a user to join or leave an event. Instead of creating a view just for the `EventGamer` model, it’s better to add custom actions to either the `EventView`, since the `Event` model is the one that has the `ManyToManyField`. Custom actions on a view allow for more than just basic CRUD functionality.
## Learning Objectives

* You should be able to remember that a custom action is a method on a ViewSet.
* You should be able to understand that a custom action allows the client to put a verb at the end of the URL to initiate a custom action.
* You should be able to remember that a custom action can specify which HTTP methods are supported by it.
* You should be able to create a custom action that includes the pk of object you want to retrieve from the database


## Custom Action

With Django REST Framework, you can create a custom action that your API will support by using the `@action` decorator above a method within a ViewSet. For this action, you want a client to make a request to allow a gamer to sign up for an event.

There will also be an action to allow a gamer to leave an event.

## Signup Method

Add the following code to the  `EventView`

Add this one to the imports at the top
```py
from rest_framework.decorators import action
```

```py
@action(methods=['post'], detail=True)
def signup(self, request, pk):
    """Post request for a user to sign up for an event"""
   
    gamer = Gamer.objects.get(user=request.auth.user)
    event = Event.objects.get(pk=pk)
    event.attendees.add(gamer)
    return Response({'message': 'Gamer added'}, status=status.HTTP_201_CREATED)
    

```

Using the `action` decorator turns a method into a new route. In this case, the action will accept `POST` methods and because `detail=True` the url will include the pk. Since we need to know which event the user wants to sign up for we’ll need to have the pk. The route is named after the function. So to call this method the url would be `http://localhost:8000/events/2/signup`

Just like in the `create` method, we get the gamer that’s logged in, then the event by it’s `pk`. The `ManyToManyField` , `attendees`, on the `Event` model takes care of most of the hard work. The `add` method on `attendees` creates the relationship between this event and gamer by adding the `event_id` and `gamer_id` to the join table. The response then sends back a `201` status code.

### Postman
Make a `POST` request to `http://localhost:8000/events/1/signup`. If it was successful check the join `event_gamer` join table to see the new row that was added. 

## On your own
Now there needs to be a way for a gamer to leave an event.
1. Write a new method named `leave`
2. It should have the `action` decorator
3. It should accept `DELETE` requests
4. It should be a detail route
5. Get the gamer and the event objects
6. Use the `remove` method on the `ManyToManyField` to delete the gamer from the join table
7. Return a `204` Response
8. Test in Postman by sending a `DELETE` request to `http://localhost:8000/events/1/leave`
