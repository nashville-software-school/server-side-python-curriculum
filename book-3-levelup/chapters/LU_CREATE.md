# Writing the `create` method

The `create` method will handle the `POST` requests to the resource. In this chapter, we’ll add the `create` method to the `GameView` and `EventView`.

## Create a Game

Before writing the create code, take a look back at the `Game` model. We’ll need values from the client for all of the fields on the model.

Here’s the code to create a game. We’ll break it down next.

```python
def create(self, request):
    """Handle POST operations

    Returns
        Response -- JSON serialized game instance
    """
    gamer = Gamer.objects.get(uid=request.data["userId"])
    game_type = GameType.objects.get(pk=request.data["gameType"])

    game = Game.objects.create(
        title=request.data["title"],
        maker=request.data["maker"],
        number_of_players=request.data["numberOfPlayers"],
        skill_level=request.data["skillLevel"],
        game_type=game_type,
        gamer=gamer,
    )
    serializer = GameSerializer(game)
    return Response(serializer.data)
```

Inside the method, the first line of code is retrieving the `Gamer` object from the database. We do this to make sure the user that we're trying to add the new game actually exists in the database.

The data passed in from the client is held in the `request.data` dictionary. Whichever keys are used on the `request.data` must match what the client is passing to the server.

Next, we retrieve the `GameType` object from the database.

To add the game to the database, we call the `create` ORM method and pass the fields as parameters to the function. Here’s the sql that will run:

```python
db_cursor.execute("""
Insert into levelupapi_game (title, maker, number_of_players, skill_level, gamer_id, game_type_id)
values (?, ?, ?, ?, ?, ?)
""", (request.data["title"], request.data["maker"], request.data["numberOfPlayers"], request.data["skillLevel"], gamer, game_type))
```

After the `create` has finished the `game` variable is now the new game instance, including the new id. That object can be serialized and returned to the client now just like in the `retrieve` method

### Try it in Postman

Since we’ve added the `create` method to the view class, the `router` inside of `urls.py` already knows that this will be an acceptable route to hit. All `POST` calls to `http://localhost:8000/games` will now call the `create` method. Open up Postman to try it out. Add this game to the request body:

```json
{
    "title": "CodeNames",
    "maker": "CGE",
    "numberOfPlayers": 6,
    "skillLevel": 3,
    "gameType": 2,
    "userId": 1
}
```

## On Your Own

Add the `create` method to the `EventView`. Take a look at the `Event` model to remember which fields you’ll need to account for. By the end, a `POST` request to `http://localhost:8000/events` should add a new event to the database.
