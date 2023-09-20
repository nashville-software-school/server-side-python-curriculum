# Filter All Games

Right now the list method for games just returns everything from the table. What if you wanted to pass in a query string parameter?

Go to your `list` metehod in the `GameView` and be ready to make some changes to the logic . Before sending the `games` list to the serializer, check to see if a query string parameter has been passed in the URL. For this example, you’ll say you want a way to filter by the game type.

The URL from the client will look like`http://localhost:8000/games?type=1`. There’s no need to parse the URL here because the `ViewSet` class that the `GameView` is inheriting from has done that for us:

```py
games = Game.objects.all()

# Add in the next 3 lines
game_type = request.query_params.get('type', None)
if game_type is not None:
    games = games.filter(game_type_id=game_type)

serializer = GameSerializer(games, many=True)
return Response(serializer.data)
```

The `request` from the method parameters holds all the information for the request from the client. The `request.query_params` is a dictionary of any query parameters that are in the url.

Using the `get()` method on a dictionary is a safe way to find if a key is present on the dictionary. If the `'type'` key is not present on the dictionary it will return `None`.

After getting a value for `game_type`, you can use the ORM `filter` method to only include games with that game type. This is the equivalent of this command:

```py
db_cursor.execute("""
    select *
    from levelupapi_game
    where game_type_id = ?
""", (game_type,))
```

Since you’re just overwriting the value of the `games` variable nothing else in the function needs to change.

Try it out in your API client - `http://localhost:8000/games?type=1`

If you get back empty array, make sure you have a game with a `game_type_id` of 1.
