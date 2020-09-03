# Listing Games

## Preface: Seed the Database

Create the fixture below and then seed the database with the following command

```sh
python manage.py loaddata events
```

> #### `levelup/levelupapi/fixtures/events.json`

```json
[
    {
        "model": "levelupapi.event",
        "pk": 1,
        "fields": {
            "organizer": 1,
            "description": "Welcome To at lunch",
            "game": 1,
            "date": "2021-10-04",
            "time": "12:00"
        }
    },
    {
        "model": "levelupapi.event",
        "pk": 2,
        "fields": {
            "organizer": 1,
            "description": "Friday night Settlers and drinks",
            "game": 2,
            "date": "2021-08-14",
            "time": "19:30"
        }
    },
    {
        "model": "levelupapi.event",
        "pk": 3,
        "fields": {
            "organizer": 1,
            "description": "Vale of the Frost King campaign. All weekend.",
            "game": 3,
            "date": "2021-04-20",
            "time": "8:00"
        }
    }
]
```

## Step 1: The Event Model Class

You should already have the **`Event`** model for your application. If not, build it now after looking at the requirements in chapter 2.

## Step 2: The Event ViewSet

Time to write the brains of the operation. The ViewSet will handle GET, POST, PUT, and DELETE requests sent from a client application over the HTTP protocol.

> #### `levelup/levelupapi/views/event.py`

```py
"""View module for handling requests about events"""
from django.contrib.auth.models import User
from django.core.exceptions import ValidationError
from django.http import HttpResponseServerError
from rest_framework import status
from rest_framework.decorators import action
from rest_framework.viewsets import ViewSet
from rest_framework.response import Response
from rest_framework import serializers
from levelupapi.models import Game, Event, Gamer
from levelupapi.views.game import GameSerializer


class Events(ViewSet):
    """Level up events"""

    def create(self, request):
        """Handle POST operations for events

        Returns:
            Response -- JSON serialized event instance
        """
        gamer = Gamer.objects.get(user=request.auth.user)

        event = Event()
        event.time = request.data["time"]
        event.date = request.data["date"]
        event.description = request.data["description"]
        event.organizer = gamer

        game = Game.objects.get(pk=request.data["gameId"])
        event.game = game

        try:
            event.save()
            serializer = EventSerializer(event, context={'request': request})
            return Response(serializer.data)
        except ValidationError as ex:
            return Response({"reason": ex.message}, status=status.HTTP_400_BAD_REQUEST)

    def retrieve(self, request, pk=None):
        """Handle GET requests for single event

        Returns:
            Response -- JSON serialized game instance
        """
        try:
            event = Event.objects.get(pk=pk)
            serializer = EventSerializer(event, context={'request': request})
            return Response(serializer.data)
        except Exception:
            return HttpResponseServerError(ex)

    def update(self, request, pk=None):
        """Handle PUT requests for an event

        Returns:
            Response -- Empty body with 204 status code
        """
        organizer = Gamer.objects.get(user=request.auth.user)

        event = Event.objects.get(pk=pk)
        event.description = request.data["description"]
        event.date = request.data["date"]
        event.time = request.data["time"]
        event.organizer = organizer

        game = Game.objects.get(pk=request.data["gameId"])
        event.game = game
        event.save()

        return Response({}, status=status.HTTP_204_NO_CONTENT)

    def destroy(self, request, pk=None):
        """Handle DELETE requests for a single game

        Returns:
            Response -- 200, 404, or 500 status code
        """
        try:
            event = Event.objects.get(pk=pk)
            event.delete()

            return Response({}, status=status.HTTP_204_NO_CONTENT)

        except Event.DoesNotExist as ex:
            return Response({'message': ex.args[0]}, status=status.HTTP_404_NOT_FOUND)

        except Exception as ex:
            return Response({'message': ex.args[0]}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def list(self, request):
        """Handle GET requests to events resource

        Returns:
            Response -- JSON serialized list of events
        """
        events = Event.objects.all()

        # Support filtering events by game
        game = self.request.query_params.get('gameId', None)
        if game is not None:
            events = events.filter(game__id=type)

        serializer = EventSerializer(
            events, many=True, context={'request': request})
        return Response(serializer.data)
```

## Step 3: The Serializers

The serializer class determines how the Python data should be serialized as JSON to be sent back to the client. Put the following code at the bottom of the same module as above.

You'll immediately notice that there are three serializers defined for this module.

The **`EventSerializer`** class uses the magical _HyperlinkedModelSerializer_ to generate a URL for the JSON serialized event. An event has two related entities:

1. An organizer _(a.k.a. a Gamer)_
1. A game

In a case where you don't want those related entities to be serialized with an auto-generated URL, you can use the less magical _ModelSerializer_. The reason you don't need those to be hyperlink serialized in this case is because they are nested entities inside the event object.

Therefore, the client likely doesn't care about the URL for the organizer or the game, only the event itself. The event gets serialized with a URL, and that serialization process, in turn, serializes its related entities without a URL on them.

This is your first glimpse into how much control you _can_ have over how your data is serialized into JSON.

You can use _HyperlinkedModelSerializer_ with the depth meta property set to let Django handle the entire serialization process for you, including related entities. You can also choose to use the _ModelSerializer_ to serialize any Python list/object without all the magic.

> #### `levelup/levelupapi/views/event.py`

```py
class EventSerializer(serializers.HyperlinkedModelSerializer):
    """JSON serializer for events"""
    organizer = EventGamerSerializer(many=False)
    game = GameSerializer(many=False)

    class Meta:
        model = Event
        url = serializers.HyperlinkedIdentityField(
            view_name='event',
            lookup_field='id'
        )
        fields = ('id', 'url', 'game', 'organizer',
                  'description', 'date', 'time')

class EventUserSerializer(serializers.ModelSerializer):
    """JSON serializer for event organizer's related Django user"""
    class Meta:
        model = User
        fields = ['first_name', 'last_name', 'email']


class EventGamerSerializer(serializers.ModelSerializer):
    """JSON serializer for event organizer"""
    user = EventUserSerializer(many=False)

    class Meta:
        model = Gamer
        fields = ['user']

class GameSerializer(serializers.HyperlinkedModelSerializer):
    """JSON serializer for games"""
    class Meta:
        model = Game
        fields = ('id', 'title', 'maker', 'number_of_players', 'skill_level')
```

## Step 4: The URL

The last step is for the server to specify which URL it will respond to with information about events. In this case, you want to expose a `/events` resource at the end of the base API.

http://localhost:8000/events

and

http://localhost:8000/events/1

If any client submits a GET request to either one of those URLs, you need to clearly state that the **`Events`** ViewSet will handle the request.

Update the following import statement at the top of the urls module.

> #### `levelup/levelup/urls.py`

```py
from levelupapi.views import Games, GameTypes, Events
```

Then, add a new URL mapping to the default router.

> #### `levelup/levelup/urls.py`

```py
router = routers.DefaultRouter(trailing_slash=False)
router.register(r'gametypes', GameTypes, 'gametype')
router.register(r'games', Games, 'game')
router.register(r'events', Events, 'event')
```

## Client Code

You can start off with this starter React code to request and display a list of games from the API.

> #### `src/components/game/EventProvider.js`

```jsx
import React, { useState } from "react"

export const EventContext = React.createContext()

export const EventProvider = (props) => {
    const [ events, setEvents ] = useState([])

    const getEvents = () => {
        return fetch("http://localhost:8000/events", {
            headers:{
                "Authorization": `Token ${localStorage.getItem("lu_token")}`
            }
        })
            .then(response => response.json())
            .then(setEvents)
    }

    return (
        <EventContext.Provider value={{ events, getEvents }} >
            { props.children }
        </EventContext.Provider>
    )
}
```

> #### `src/components/game/EventList.js`

```jsx
import React, { useContext, useEffect } from "react"
import { EventContext } from "./EventProvider.js"

export const EventList = (props) => {
    const { events, getEvents } = useContext(EventContext)

    useEffect(() => {
        getEvents()
    }, [])

    return (
        <article className="events">
            <header className="events__header">
                <h1>Level Up Game Events</h1>
            </header>
            {
                events.map(event => {
                    return <section key={event.id} className="registration">
                        <div className="registration__game">{event.game.title}</div>
                        <div>{event.description}</div>
                        <div>
                            {
                                new Date(date).toLocaleDateString("en-US",
                                {
                                    weekday: 'long',
                                    year: 'numeric',
                                    month: 'long',
                                    day: 'numeric'
                                })
                                @ {event.time}
                            }
                        </div>
                    </section>
                })
            }
        </article >
    )
}
```

> #### `src/components/ApplicationViews.js`

```jsx
<EventProvider>
    <Route exact path="/events">
        <EventList />
    </Route>
</EventProvider>
```