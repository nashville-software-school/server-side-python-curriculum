# Editing Games

## Learning Objectives

* You should be able to explain which HTTP method is used by the client to trigger an edit request.
* You should be able to identify which method on a ViewSet is invoked when the client has requested a change in state for a resource.
* You should be able to recite which HTTP status code should be on a response to an edit request.

## API View Code

The code for updating is *very* similar to the creation code. The major difference is that while in the creation code, you had to create a new database model instance...

```py
game = Game()
```

In the `update()` code block, you have to find the existing game first, and then modify its properties.

```py
game = Game.objects.get(pk=pk)
```

If the client sends a PUT request to http://localhost:8000/games/3, then the route parameter of `3` becomes the value of the `pk` parameter below.

> #### `levelup/levelupapi/views/game.py`

```py
def update(self, request, pk=None):
    """Handle PUT requests for a game

    Returns:
        Response -- Empty body with 204 status code
    """
    gamer = Gamer.objects.get(user=request.auth.user)

    game = Game.objects.get(pk=pk)
    game.title = request.data["title"]
    game.maker = request.data["maker"]
    game.number_of_players = request.data["numberOfPlayers"]
    game.skill_level = request.data["skillLevel"]
    game.gamer = gamer

    gametype = GameType.objects.get(pk=request.data["gameTypeId"])
    game.gametype = gametype
    game.save()

    return Response({}, status=status.HTTP_204_NO_CONTENT)
```

The ORM would end up executing the following SQL statement after `game = Game.objects.get(pk=pk)` is evaluated.

```sql
SELECT
    title,
    maker,
    number_of_players,
    skill_level,
    gamer_id,
    gametype_id
FROM
    levelupapi_game
WHERE
    id = 3
```

## Client Implementation

This 10-minute video shows an anonymous developer updating the React code to implement the ability to edit a game and utilize the `update()` method in the Django API.

[LevelUp - Game Edit Implementation](https://youtu.be/D5T0zs5UrHQ)