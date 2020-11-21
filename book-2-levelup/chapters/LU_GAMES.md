# Listing Games

## Preface: Seed the Database

Create the following fixture file and then seed the database with the loaddata command beneath.

> #### `levelup/levelupapi/fixtures/games.json`

```json
[
    {
        "model": "levelupapi.game",
        "pk": 1,
        "fields": {
            "title": "Welcome To",
            "maker": "Benoit Turpin",
            "gamer": 1,
            "gametype": 1,
            "number_of_players": 4,
            "skill_level": 3
        }
    },
    {
        "model": "levelupapi.game",
        "pk": 2,
        "fields": {
            "title": "Settlers of Catan",
            "maker": "Klaus Teuber",
            "gamer": 1,
            "gametype": 1,
            "number_of_players": 4,
            "skill_level": 4
        }
    },
    {
        "model": "levelupapi.game",
        "pk": 3,
        "fields": {
            "title": "Dungeons & Dragons",
            "maker": "Wizards of the Coast",
            "gamer": 1,
            "gametype": 2,
            "number_of_players": 5,
            "skill_level": 3
        }
    }
]
```

#### Load the fixture data

```sh
python manage.py loaddata games
```



## Step 1: The Game Model Class

You should already have the **`Game`** model for your application. If not, build it now after looking at the requirements in chapter 2.

## Step 2: The Game ViewSet

Time to write the brains of the operation. The ViewSet will handle GET, POST, PUT, and DELETE requests sent from a client application over the HTTP protocol.

> #### `levelup/levelupapi/views/game.py`

```py
"""View module for handling requests about games"""
from django.core.exceptions import ValidationError
from rest_framework import status
from django.http import HttpResponseServerError
from rest_framework.viewsets import ViewSet
from rest_framework.response import Response
from rest_framework import serializers
from rest_framework import status
from levelupapi.models import Game, GameType, Gamer


class Games(ViewSet):
    """Level up games"""

    def create(self, request):
        """Handle POST operations

        Returns:
            Response -- JSON serialized game instance
        """

        # Uses the token passed in the `Authorization` header
        gamer = Gamer.objects.get(user=request.auth.user)

        # Create a new Python instance of the Game class
        # and set its properties from what was sent in the
        # body of the request from the client.
        game = Game()
        game.title = request.data["title"]
        game.maker = request.data["maker"]
        game.number_of_players = request.data["numberOfPlayers"]
        game.skill_level = request.data["skillLevel"]
        game.gamer = gamer

        # Use the Django ORM to get the record from the database
        # whose `id` is what the client passed as the
        # `gameTypeId` in the body of the request.
        gametype = GameType.objects.get(pk=request.data["gameTypeId"])
        game.gametype = gametype

        # Try to save the new game to the database, then
        # serialize the game instance as JSON, and send the
        # JSON as a response to the client request
        try:
            game.save()
            serializer = GameSerializer(game, context={'request': request})
            return Response(serializer.data)

        # If anything went wrong, catch the exception and
        # send a response with a 400 status code to tell the
        # client that something was wrong with its request data
        except ValidationError as ex:
            return Response({"reason": ex.message}, status=status.HTTP_400_BAD_REQUEST)



    def retrieve(self, request, pk=None):
        """Handle GET requests for single game

        Returns:
            Response -- JSON serialized game instance
        """
        try:
            # `pk` is a parameter to this function, and
            # Django parses it from the URL route parameter
            #   http://localhost:8000/games/2
            #
            # The `2` at the end of the route becomes `pk`
            game = Game.objects.get(pk=pk)
            serializer = GameSerializer(game, context={'request': request})
            return Response(serializer.data)
        except Exception as ex:
            return HttpResponseServerError(ex)

    def update(self, request, pk=None):
        """Handle PUT requests for a game

        Returns:
            Response -- Empty body with 204 status code
        """
        gamer = Gamer.objects.get(user=request.auth.user)

        # Do mostly the same thing as POST, but instead of
        # creating a new instance of Game, get the game record
        # from the database whose primary key is `pk`
        game = Game.objects.get(pk=pk)
        game.title = request.data["title"]
        game.maker = request.data["maker"]
        game.number_of_players = request.data["numberOfPlayers"]
        game.skill_level = request.data["skillLevel"]
        game.gamer = gamer

        gametype = GameType.objects.get(pk=request.data["gameTypeId"])
        game.gametype = gametype
        game.save()

        # 204 status code means everything worked but the
        # server is not sending back any data in the response
        return Response({}, status=status.HTTP_204_NO_CONTENT)

    def destroy(self, request, pk=None):
        """Handle DELETE requests for a single game

        Returns:
            Response -- 200, 404, or 500 status code
        """
        try:
            game = Game.objects.get(pk=pk)
            game.delete()

            return Response({}, status=status.HTTP_204_NO_CONTENT)

        except Game.DoesNotExist as ex:
            return Response({'message': ex.args[0]}, status=status.HTTP_404_NOT_FOUND)

        except Exception as ex:
            return Response({'message': ex.args[0]}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def list(self, request):
        """Handle GET requests to games resource

        Returns:
            Response -- JSON serialized list of games
        """
        # Get all game records from the database
        games = Game.objects.all()

        # Support filtering games by type
        #    http://localhost:8000/games?type=1
        #
        # That URL will retrieve all tabletop games
        game_type = self.request.query_params.get('type', None)
        if game_type is not None:
            games = games.filter(gametype__id=game_type)

        serializer = GameSerializer(
            games, many=True, context={'request': request})
        return Response(serializer.data)
```

## Step 3: The Serializer

The serializer class determines how the Python data should be serialized as JSON to be sent back to the client. Put the following code at the bottom of the same module as above.

> #### `levelup/levelupapi/views/game.py`

```py
class GameSerializer(serializers.ModelSerializer):
    """JSON serializer for games

    Arguments:
        serializer type
    """
    class Meta:
        model = Game
        fields = ('id', 'title', 'maker', 'number_of_players', 'skill_level', 'gametype')
        depth = 1
```

## Step 4: The URL

The last step is for the server to specify which URL it will respond to with information about games. In this case, you want to expose a `/games` resource at the end of the base API.

http://localhost:8000/games

and

http://localhost:8000/games/1

If any client submits a GET request to either one of those URLs, you need to clearly state that the **`Games`** ViewSet will handle the request. You will use a built-in class in Django called the `DefaultRouter`.


Add the following import statement at the top of the urls module.

> #### `levelup/levelup/urls.py`

```py
from levelupapi.views import GameTypes, Games
```

Then, add a new URL mapping to the default router.

> #### `levelup/levelup/urls.py`

```py
router = routers.DefaultRouter(trailing_slash=False)
router.register(r'gametypes', GameTypes, 'gametype')
router.register(r'games', Games, 'game')
```

## Client Code

You can start off with this starter React code to request and display a list of games from the API.

> #### `src/components/game/GameProvider.js`

```jsx
import React, { useState } from "react"

export const GameContext = React.createContext()

export const GameProvider = (props) => {
    const [ games, setGames ] = useState([])

    const getGames = () => {
        return fetch("http://localhost:8000/games", {
            headers:{
                "Authorization": `Token ${localStorage.getItem("lu_token")}`
            }
        })
            .then(response => response.json())
            .then(setGames)
    }

    return (
        <GameContext.Provider value={{ games, getGames }} >
            { props.children }
        </GameContext.Provider>
    )
}
```

> #### `src/components/game/GameList.js`

```jsx
import React, { useContext, useEffect } from "react"
import { GameContext } from "./GameProvider.js"

export const GameList = (props) => {
    const { games, getGames } = useContext(GameContext)

    useEffect(() => {
        getGames())
    }, [])

    return (
        <article className="games">
            {
                games.map(game => {
                    return <section key={`game--${game.id}`} className="game">
                        <div className="game__title">{game.title} by {game.maker}</div>
                        <div className="game__players">{game.number_of_players} players needed</div>
                        <div className="game__skillLevel">Skill level is {game.skill_level}</div>
                    </section>
                })
            }
        </article>
    )
}
```

> #### `src/components/ApplicationViews.js`

```jsx
<GameProvider>
    <Route exact path="/">
        <GameList />
    </Route>
</GameProvider>
```