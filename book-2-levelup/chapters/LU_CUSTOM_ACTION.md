# Joining an Event

In this chapter, you are going to to allow gamers to sign up for an event that has been scheduled.

![animation showing joining an event](./images/levelup-join.gif)

## Custom Action

With Django REST Framework, you can create a custom action that your API must support by using the `@action` decorator above a ViewSet. For this action, you want a client to create a request that allows a gamer to sign up for an event.

You also want to allow a client to allow a gamer to cancel their signup for an event.

This mean that your custom action needs to support `POST`, and `DELETE` verbs.

There are actually many ways to design this, and this chapter will show you one of them. You are going to support requests to the following URL.

http://localhost:8000/events/2/signup

The resource is `events`. The route parameter of `2` specifies which event is being targeted. The `signup` method at the end is your custom action.

## Signup Method

Add the following method to your event viewset.

> #### `levelup/levelupapi/views/event.py`

```py
    @action(methods=['get', 'post', 'delete'], detail=True)
    def signup(self, request, pk=None):
        """Managing gamers signing up for events"""

        # A gamer wants to sign up for an event
        if request.method == "POST":
            # The pk would be `2` if the URL above was requested
            event = Event.objects.get(pk=pk)

            # Django uses the `Authorization` header to determine
            # which user is making the request to sign up
            gamer = Gamer.objects.get(user=request.auth.user)

            try:
                # Determine if the user is already signed up
                registration = EventGamers.objects.get(
                    event=event, gamer=gamer)
                return Response(
                    {'message': 'Gamer already signed up this event.'},
                    status=status.HTTP_422_UNPROCESSABLE_ENTITY
                )
            except EventGamers.DoesNotExist:
                # The user is not signed up.
                registration = EventGamers()
                registration.event = event
                registration.gamer = gamer
                registration.save()

                return Response({}, status=status.HTTP_201_CREATED)

        # User wants to leave a previously joined event
        elif request.method == "DELETE":
            # Handle the case if the client specifies a game
            # that doesn't exist
            try:
                event = Event.objects.get(pk=pk)
            except Event.DoesNotExist:
                return Response(
                    {'message': 'Event does not exist.'},
                    status=status.HTTP_400_BAD_REQUEST
                )

            # Get the authenticated user
            gamer = Gamer.objects.get(user=request.auth.user)

            try:
                # Try to delete the signup
                registration = EventGamers.objects.get(
                    event=event, gamer=gamer)
                registration.delete()
                return Response(None, status=status.HTTP_204_NO_CONTENT)

            except EventGamers.DoesNotExist:
                return Response(
                    {'message': 'Not currently registered for event.'},
                    status=status.HTTP_404_NOT_FOUND
                )

        # If the client performs a request with a method of
        # anything other than POST or DELETE, tell client that
        # the method is not supported
        return Response({}, status=status.HTTP_405_METHOD_NOT_ALLOWED)
```

## Event Provider Method

In the event provider, create the function to be invoked when the current gamer wants to join a specific event. This request has everything the server needs to create the relationship.

1. The event via the `eventId` parameter
1. The user via the `Authorization` token

```js
const joinEvent = eventId => {
    return fetch(`http://localhost:8000/events/${ eventId }/signup`, {
        method: "POST",
        headers:{
            "Authorization": `Token ${localStorage.getItem("lu_token")}`
        }
    })
        .then(response => response.json())
}
```

## Join and Leave Buttons

Now you need to update your **`EventList`** component in the client to allow the user to leave or join an event. Note that the `joinEvent()` function was added the the deconstructed object from the event context.

Then that function is invoked when the join button - which is on the bottom of each event card - is clicked.

```jsx
import React, { useContext, useEffect } from "react"
import { EventContext } from "./EventProvider.js"
import "./Events.css"

export const EventList = (props) => {
    const { events, getEvents, joinEvent } = useContext(EventContext)

    useEffect(() => {
        getEvents()
    }, [])

    return (
        <article className="events">
            <header className="events__header">
                <h1>Level Up Game Events</h1>
                <button className="btn btn-2 btn-sep icon-create"
                    onClick={() => {
                        props.history.push({ pathname: "/events/new" })
                    }}
                >Schedule New Event</button>
            </header>
            {
                events.map(event => {
                    const attending = profile.events.some(evt => evt.id === event.id)
                    return <section key={event.id} className="registration">
                        <div className="registration__game">{event.game.title}</div>
                        <div>{event.description}</div>
                        <div>
                            {event.date} @ {event.time}
                        </div>
                        <button className="btn btn-2"
                                onClick={() => joinEvent(event.id)}
                        >Join</button>
                    </section>
                })
            }
        </article >
    )
}
```