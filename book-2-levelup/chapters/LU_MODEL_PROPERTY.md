# Joining and Leaving Events

In the previous chapter, you implemented full-stack code that let an authenticated user join an event.

In this chapter, you are going to implement full-stack code that will allow gamers to easily join _**and**_ leave scheduled events. You will also implement reactive code that will immediately show if the user is currently attending the event or not.

You will learn about custom Django model properties, use a JavaScript ternary statement to show the correct UI element, use `onClick()` handlers in React, and implement a custom action - a feature available in Django REST Framework view sets.

![animation of joining and leaving events in the client](./images/levelup-join-leave.gif)

## Learning Objective

* You should be able to explain that extra serializer fields can exist on the serializer, but is not a column in the database.
* You should be able to recognize the 

## Extra Serializer Fields

In this chapter, you are going to add a `joined` property to the **`Event`** that will let the client application know if the currently authenticated user is going to an event.

Assume there are 4 events.

A user has signed up for events #2 and #4.

When that user is authenticated, and the client requests a list of all events, the JSON would look like the representations below. Note the value of the `joined` property on each event. That data is not in the database, but rather calculated by the view logic and put in the JSON by the serializer.

You'll see how later in the chapter.

```json
[
    {
        "id": 1,
        "game": {
            "title": "Welcome To"
        },
        "description": "Welcome To at lunch",
        "date": "2021-10-04",
        "time": "12:00:00",
        "joined": false
    },
    {
        "id": 2,
        "game": {
            "title": "Settlers of Catan",
        },
        "description": "Friday night Settlers and drinks",
        "date": "2021-08-14",
        "time": "19:30:00",
        "joined": true
    },
    {
        "id": 3,
        "game": {
            "title": "Dungeons & Dragons",
        },
        "description": "Vale of the Frost King campaign. All weekend.",
        "date": "2021-04-20",
        "time": "08:00:00",
        "joined": false
    },
    {
        "id": 10,
        "game": {
            "title": "Welcome To",
        },
        "description": "Lightning round welcome to session. Cards will be turned every minute. Drinking involved.",
        "date": "2020-11-11",
        "time": "17:30:00",
        "joined": true
    }
]
```

## Event Serializer

Update the **`EventSerializer`** class to include the new field. The `joined` variable tells the serializer what type of data it will be, in this case, `joined` will be a boolean. Then the field is added to the `fields` tuple.

```py
class EventSerializer(serializers.ModelSerializer):
    """JSON serializer for events"""
    # if you have other variables outside the Meta class just add this line
    joined = serializers.BooleanField(required=False)

    class Meta:
        model = Event
        fields = ('id', 'game', 'host',
                  'description', 'date',
                  'time', 'attendees', 'joined')
```

## List of Events

Update the list method in the event viewset with the code below.

```py
    def list(self, request):
        """Handle GET requests to events resource

        Returns:
            Response -- JSON serialized list of events
        """
        # Get the current authenticated user
        gamer = Gamer.objects.get(user=request.auth.user)
        events = Event.objects.all()

        # Set the `joined` property on every event
        for event in events:
            # Check to see if the gamer is in the attendees list on the event
            event.joined = gamer in event.attendees.all()

        # Support filtering events by game
        game = self.request.query_params.get('gameId', None)
        if game is not None:
            events = events.filter(game__id=type)

        serializer = EventSerializer(
            events, many=True, context={'request': request})
        return Response(serializer.data)
```

## Event Manager Method

In the event manager, create the function to be invoked when the current gamer wants to join a specific event. This request has everything the server needs to remove the relationship.

1. The event via the `eventId` parameter
1. The user via the `Authorization` token

> **Note:** The `.then(getEvents)` method was also added to the promise chain for `joinEvent()`. Make sure you have that in your function.

```js
export const leaveEvent = eventId => {
    return fetch(`http://localhost:8000/events/${ eventId }/signup`, {
        method: "DELETE",
        headers:{
            "Authorization": `Token ${localStorage.getItem("lu_token")}`
        }
    })
        .then(response => response.json())
        .then(getEvents)
}

export const joinEvent = eventId => {
    return fetch(`http://localhost:8000/events/${ eventId }/signup`, {
        method: "POST",
        headers:{
            "Authorization": `Token ${localStorage.getItem("lu_token")}`
        }
    })
        .then(response => response.json())
        .then(getEvents)
}
```

## Join and Leave Buttons

Time for all of your hard work to pay off. You will now use the `joined` property on each event to display a Join button, or a Leave button on each event.

In React, you need to update your **`EventList`** component in the client to allow the user to leave or join an event. Note that the `leaveEvent()` function was added the the deconstructed object from the event context.

> **Vocabulary:** `condition ? what happens if true : what happens if false` is called a ternary statement in JavaScript. It's a condensed version of an `if..else` block of code that you can use in JSX, because interpolation only supports a single JavaScript statement.

```jsx
import React, { useEffect } from "react"
import { useHistory } from "react-router-dom"
import { getEvents, joinEvent, leaveEvent } from "./EventManager.js"
import "./Events.css"

export const EventList = () => {
    const history = useHistory()
    const [ events, updateEvents ] = useState([])

    const eventFetcher = () => {
        getEvents().then(data => updateEvents(data))
    }

    useEffect(() => {
        eventFetcher()
    }, [])

    return (
        <article className="events">
            <header className="events__header">
                <h1>Level Up Game Events</h1>
                <button className="btn btn-2 btn-sep icon-create"
                    onClick={() => {
                        history.push({ pathname: "/events/new" })
                    }}
                >Schedule New Event</button>
            </header>
            {
                events.map(event => {
                    return <section key={event.id} className="registration">
                        <div className="registration__game">{event.game.title}</div>
                        <div>{event.description}</div>
                        <div>
                            {event.date} @ {event.time}
                        </div>
                        {
                            event.joined
                                ? <button className="btn btn-3"
                                    onClick={() => leaveEvent(event.id).then(() => eventFetcher())}
                                    >Leave</button>
                                : <button className="btn btn-2"
                                    onClick={() => joinEvent(event.id).then(() => eventFetcher())}
                                    >Join</button>
                        }
                    </section>
                })
            }
        </article>
    )
}
```
