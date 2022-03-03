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
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny
from rest_framework.response import Response


@api_view(['GET'])
def user_profile(request):
    """Handle GET requests to profile resource

    Returns:
        Response -- JSON representation of user info and events
    """
    gamer = Gamer.objects.get(user=request.auth.user)
    
    # TODO: Use the django orm to filter events if the gamer is attending the event
    # attending = 

    # TODO: Use the orm to filter events if the gamer is hosting the event
    # hosting =

    attending = EventSerializer(
        attending, many=True, context={'request': request})
    hosting = EventSerializer(
        hosting, many=True, context={'request': request})
    gamer = GamerSerializer(
        gamer, many=False, context={'request': request})

    # Manually construct the JSON structure you want in the response
    profile = {
        "gamer": gamer.data,
        "attending": attending.data,
        "hosting": hosting.data
    }

    return Response(profile)
```

## Profile Serializers

Beneath that function, in the same module, add these serializers to customize how the JSON representation will be built.

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


class GameSerializer(serializers.ModelSerializer):
    """JSON serializer for games"""
    class Meta:
        model = Game
        fields = ('title',)


class EventSerializer(serializers.ModelSerializer):
    """JSON serializer for events"""
    game = GameSerializer(many=False)

    class Meta:
        model = Event
        fields = ('id', 'game', 'description', 'date', 'time')
```

## Profile URL

Now to make the profile available to a client, the last step is to create a URL for it. Since this is a function view instead of a class view we'll add the url like we've added the login and register routes. In the `urlpatterns` list add this line:

```py
path('profile', user_profile),
```

_Make sure to import the `user_profile` function into the `urls.py`_


## Client Request


### State Manager

On the client side, create a new manager to hold the fetch call.

> #### `src/components/auth/ProfileManager.js`

```jsx
export const getProfile = () => {
    // TODO: Add the fetch call to the profile resource
}
    
```

### Profile Component


```jsx
import React, { useEffect } from "react"
import { getProfile } from "./ProfileManager.js"
import "./Profile.css"


export const Profile = () => {
    const [ profile, changeProfile ] = useState([])

    useEffect(() => {
        getProfile().then(data => changeProfile(data))
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
                {/* TODO: show the user's first and last name */}
                    Welcome: firstName lastName
                </div>
                {/* TODO: show the user's username */}
                <div className="profile__username">Username: username</div>
                {/* TODO: show the user's bio */}
                <div className="profile__bio">About you: bio</div>
            </section>
            <section className="profile__registrations">
                <header className="registrations__header">
                    <h3>Events you are attending</h3>
                </header>
                <div className="registrations">
                    {/* TODO: Map through the events the user is attending */}
                </div>
            </section>
            <section className="profile__registrations">
                <header className="registrations__header">
                    <h3>Events you are hosting</h3>
                </header>
                <div className="registrations">
                    {/* TODO: Map through the events the user is hosting */}
                </div>
            </section>
        </article>
    )
}
```

### Profile Application View

Now add a route to **`ApplicationViews`** to display the profile view when the user clicks on the profile link in the nav bar and the browser URL changes to `/profile`.
