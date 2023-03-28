# Joining an Event

Right now, there’s no method for a user to join or leave an event. Instead of creating a view just for the `EventGamer` model, we're going to add a custom action to the `EventView`. Custom actions on a view allow for more than just basic CRUD functionality.

## Learning Objectives

* You should be able to remember that a custom action is a method on a ViewSet.
* You should be able to understand that a custom action allows the client to put a verb at the end of the URL to initiate a custom action.
* You should be able to remember that a custom action can specify which HTTP methods are supported by it.
* You should be able to create a custom action that includes the pk of object you want to retrieve from the database

## Custom Action

With Django REST Framework, you can create a custom action that your API will support by using the `@action` decorator above a method within a ViewSet. For this action, you want a client to make a request to allow a gamer to sign up for an event.

There will also be an action to allow a gamer to leave an event.

## Sign Up for Event Method

Add the following code to the  `EventView`

```py
@action(methods=['post'], detail=True)
def signup(self, request, pk):
    """Post request for a user to sign up for an event"""

    gamer = Gamer.objects.get(user=request.data["user_id"])
    event = Event.objects.get(pk=pk)
    attendee = EventGamer.objects.create(
        gamer=gamer,
        event=event
    )
    return Response({'message': 'Gamer added'}, status=status.HTTP_201_CREATED)
```

Add this one to the imports at the top

```py
from rest_framework.decorators import action
```

Using the `action` decorator turns a method into a new route. In this case, the action will accept `POST` methods and because `detail=True` the url will include the pk. Since we need to know which event the user wants to sign up for we’ll need to have the pk. The route is named after the function. So to call this method the url would be `http://localhost:8000/events/2/signup`

Just like in the `create` method, we get the gamer that’s logged in, then the event by it’s `pk`. Since this is stored in the `EventGamer` table, we need to use the ORM to create a row on that table. This table will store the `gamer_id` of the user being added to the game (who's `game_id` is stored on the row as well). The response then sends back a `201` status code.

### Postman

Make a `POST` request to `http://localhost:8000/events/1/signup`. Remember to pass it a body of:

```json
{
    "user_id": "{ADD_USER_ID_HERE}"
}
```

If it was successful check the join `event_gamer` join table to see the new row that was added.

## On your own

Now there needs to be a way for a gamer to leave an event.

1. Write a new method named `leave`
1. It should have the `action` decorator
1. It should accept `DELETE` requests
1. It should be a detail route
1. Get the gamer and the event objects
1. Use the gamer and event objects to find the event_gamer object.
1. Use the `remove` method on the event_gamer object to delete the gamer from the join table
1. Return a `204` Response
1. Test in Postman by sending a `DELETE` request to `http://localhost:8000/events/1/leave`
    * Pass the user_id in the body of the request
