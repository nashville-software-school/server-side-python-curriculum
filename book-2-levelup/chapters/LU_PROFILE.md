# Gamer Profiles

In this chapter, you are going to create a ViewSet class with a `list()` method on it, but are going to bend the rules a little bit. The `list()` method isn't going to return a list of anything, but rather a single thing. You are going to expose a URL in your Django app that will return the profile information for a single user, without the need for a route parameter of the user's `id`. Instead, the `Authorization` header will be used to identify the user.

| Method | URL |
|--|--|
| GET | http://localhost:8000/profile |

When the client sends a request to that URL, with an `Authorization` header containing a valid token, the server will respond with JSON containing information about the gamer, and the events that the gamer is attending.

## Profile JSON

There are two keys on the response object.

1. **gamer** - an object
1. **events** - an array

```json
{
    "gamer": {
        "user": {
            "first_name": "Emily",
            "last_name": "Lemmon",
            "username": "me@me.com"
        },
        "bio": "Outgoing and funny. Always have the best interests of other at heart."
    },
    "events": [
        {
            "id": 3,
            "url": "http://localhost:8000/events/3",
            "game": {
                "title": "Dungeons & Dragons"
            },
            "description": "Vale of the Frost King campaign. All weekend.",
            "date": "2021-04-20",
            "time": "08:00:00"
        },
        {
            "id": 10,
            "url": "http://localhost:8000/events/10",
            "game": {
                "title": "Welcome To"
            },
            "description": "Lightning round welcome to session. Cards will be turned every minute. Drinking involved.",
            "date": "2020-11-11",
            "time": "17:30:00"
        }
    ]
}
```

## Profile Client View

This will let you build a view in your React client that looks like this.

![](./images/levelup-profile.png)

## Django Profile View

The first step is to create a ViewSet for building profile data. In this view set, you will see how you can define any structure you want for your JSON response. Just create a dictionary, and add any key/value pairs that you want.

The `Response` class that is built in to Django REST Framework with serialize any Python dictionary as JSON to be sent back to the client in the response.

> #### `levelup/levelupapi/views/profile.py`

```py
"""View module for handling requests about park areas"""
from django.contrib.auth.models import User
from rest_framework import status
from rest_framework.decorators import action
from rest_framework.viewsets import ViewSet
from rest_framework.response import Response
from rest_framework import serializers
from levelupapi.models import Event, Gamer


class Profile(ViewSet):
    """Gamer can see profile information"""

    def list(self, request):
        """Handle GET requests to profile resource

        Returns:
            Response -- JSON representation of user info and events
        """
        gamer = Gamer.objects.get(user=request.auth.user)
        events = Event.objects.filter(registrations__gamer=gamer)

        events = EventSerializer(
            events, many=True, context={'request': request})
        gamer = GamerSerializer(
            gamer, many=False, context={'request': request})

        # Manually construct the JSON structure you want in the response
        profile = {}
        profile["gamer"] = gamer.data
        profile["events"] = events.data

        return Response(profile)
```

## Profile Serializers

Beneath that class, in the same module, add these serializers to customize how the JSON representation will be built.

```py
class UserSerializer(serializers.ModelSerializer):
    """JSON serializer for gamer's related Django user"""
    class Meta:
        model = User
        fields = ('first_name', 'last_name', 'username')


class GamerSerializer(serializers.ModelSerializer):
    """JSON serializer for gamers"""
    user = UserSerializer(many=False)

    class Meta:
        model = Gamer
        fields = ('user', 'bio')


class GameSerializer(serializers.HyperlinkedModelSerializer):
    """JSON serializer for games"""
    class Meta:
        model = Game
        url = serializers.HyperlinkedIdentityField(
            view_name='game',
            lookup_field='id'
        )
        fields = ('title',)


class EventSerializer(serializers.HyperlinkedModelSerializer):
    """JSON serializer for events"""
    game = GameSerializer(many=False)

    class Meta:
        model = Event
        url = serializers.HyperlinkedIdentityField(
            view_name='event',
            lookup_field='id'
        )
        fields = ('id', 'url', 'game', 'description', 'date', 'time')
```

## Profile URL

Now to make the profile available to a client, the last step is to create a URL for it. Add a new entry to your DefaultRouter to make http://locahost:8000/profile a URL that your API will respond to and handle with the `Profile` viewset.

First, import the `Profile` viewset.

> #### `levelup/urls.py`

```py
from levelupapi.views import Games, GameTypes, Events, Profile
```

Then add an entry to DefaultRouter.

```py
router.register(r'profile', Profile, 'profile')
```

## Client Request


### State Provider

On the client side, create a new provider to maintain the state of the user's profile.

> #### `src/components/auth/ProfileProvider.js`

```jsx
import React, { useState } from "react"

export const ProfileContext = React.createContext()

export const ProfileProvider = (props) => {
    /*
        Must profile a default value for the `events` property
        so that React doesn't throw an error when you try to
        iterate the events array in the view.
    */
    const [profile, setProfile] = useState({events:[]})

    const getProfile = () => {
        return fetch("http://localhost:8000/profile", {
            headers: {
                "Authorization": `Token ${localStorage.getItem("lu_token")}`
            }
        })
            .then(response => response.json())
            .then(setProfile)
    }

    return (
        <ProfileContext.Provider value={{ profile, getProfile }}>
            {props.children}
        </ProfileContext.Provider>
    )
}
```

### Profile Component

Create a profile HTML representation component. In this code you will notice strange interpolations.

```js
{profile.gamer && profile.gamer.user.first_name}
```

Your instruction team will review this with you to explain how this is useful for working with React component lifecycle _(remember that the JSX is rendered before you have the data)_.

```jsx
import React, { useEffect, useContext } from "react"
import { ProfileContext } from "./ProfileProvider.js"
import "./Profile.css"


export const Profile = () => {
    const { profile, getProfile } = useContext(ProfileContext)

    useEffect(() => {
        getProfile()
    }, [])

    return (
        <article className="profile">
            <header>
                <h1>Your Profile</h1>
            </header>
            <section className="profile__info">
                <header className="profile__header">
                    <h3>Your Info</h3>
                </header>
                <div className="profile__name">
                    Welcome: {profile.gamer && profile.gamer.user.first_name} {profile.gamer && profile.gamer.user.last_name}
                </div>
                <div className="profile__username">Username: {profile.gamer && profile.gamer.user.username}</div>
                <div className="profile__bio">About you: {profile.gamer && profile.gamer.bio}</div>
            </section>
            <section className="profile__registrations">
                <header className="registrations__header">
                    <h3>Your Events</h3>
                </header>
                <div className="registrations">
                    {
                        profile.events.map(event => {
                            return <div key={event.id} className="registration">
                                <div className="registration__game">{event.game.title}</div>
                                <div>{event.description}</div>
                                <div>
                                    {event.date} @ {event.time}
                                </div>
                            </div>
                        })
                    }
                </div>
            </section>
        </article>
    )
}
```

### Profile Application View

Now add a route to **`ApplicationViews`** to display the profile view when the user clicks on the profile link in the nav bar and the browser URL changes to `/profile`.

> #### `src/components/ApplicationViews.js`

```jsx
<ProfileProvider>
    <Route exact path="/profile">
        <Profile />
    </Route>
</ProfileProvider>
```
