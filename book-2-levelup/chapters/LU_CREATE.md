# Writing the `create` method
The `create` method will handle the `POST` requests to the resource. In this chapter, we’ll add the `create` method to the `GameView` and `EventView`. 

## Create a Game
Before writing the create code, take a look back at the `Game` model. We’ll need values from the client for all of the fields on the model. 
Here’s the code to create a game. We’ll break it down next.
```python
    def create(self, request):
        """Handle POST operations

        Returns:
            Response -- JSON serialized game instance
        """
        gamer = Gamer.objects.get(user=request.auth.user)
        game_type = GameType.objects.get(pk=request.data["game_type"])

        game = Game.objects.create(
            title=request.data["title"],
            maker=request.data["maker"],
            number_of_players=request.data["number_of_players"],
            skill_level=request.data["skill_level"],
            gamer=gamer,
            game_type=game_type
        )
        serializer = GameSerializer(game)
        return Response(serializer.data)


```
Inside the method, the first line of code is getting the game that is logged in. Since all of our postman or fetch requests have the user’s auth token in the headers, the request will get the user object based on that token. From there, we use the `request.auth.user` to get the `Gamer` object based on the user. Here’s the equivalent sql.
```python
db_cursor.execute("""
select *
from levelupapi_gamer
where user = ?
""", (user,))
```

Next, we retrieve the `GameType` object from the database. We do this to make sure the game type the user is trying to add the new game actually exists in the database. 
The data passed in from the client is held in the `request.data` dictionary. Whichever keys are used on the `request.data` must match what the client is passing to the server.

To add the game to the database, we call the `create` ORM method and pass the fields as parameters to the function. Here’s the sql that will run:

```python
db_cursor.execute("""
Insert into levelupapi_game (title, maker, number_of_players, skill_level, gamer_id, game_type_id)
values (?, ?, ?, ?, ?, ?)
""", (request.data["title"], request.data["maker"], request.data["numberOfPlayers"], request.data["skillLevel"], gamer, game_type)) 
```

After the `create` has finished the `game` variable is now the new game instance, including the new id. That object can be serialized and returned to the client now just like in the `retrieve` method

### Try it in postman
Since we’ve added the `create` method to the view class, the `router` inside of `urls.py` already knows that this will be an acceptable route to hit. All `POST` calls to `http://localhost:8000/games` will now call the `create` method. Open up postman to try it out. Add this game to the request body:
```json
{
    "title": "Codenames",
    "maker": "CGE",
    "number_of_players": 6,
    "skill_level": 3,
    "game_type": 2
}
```

## On Your Own
Add the `create` method to the `EventView`. Take a look at the `Event` model to remember which fields you’ll need to account for. For now, don't add any `attendees` to the event. We'll look at adding that later. By the end, a `POST` request to `http://localhost:8000/events` should add a new event to the database.

## (Optional) Bonus
Something you'll learn quickly as a developer is users cannot be trusted. If there's an input field that's expecting a number, some user somewhere will type "seven". Try it out in Postman. In the request body, change the value of `number_of_players` to `"six"`. There's also a `max_length` on the title but if you try to add a title over the character limit right now the code will let you. Let's add a validation check to the code. 

1. First, we need to add a new serializer. This serializer will include the fields that are expected from the client. Notice it does not have the `gamer` in the fields. Since the `gamer` comes from the Auth header it will not be in the request body
```python
class CreateGameSerializer(serializers.ModelSerializer):
    class Meta:
        model = Game
        fields = ['id', 'title', 'maker', 'number_of_players', 'skill_level', 'game_type']
```

2. The new serializer will be used to validate and save the new game in the `create` method.  Here is what the updated `create` method will now look like:
    ```python
    // add this line at the top with the other imports
    from django.core.exceptions import ValidationError

    // this will replace the previous create method
    def create(self, request):
        """Handle POST operations

        Returns:
            Response -- JSON serialized game instance
        """
        gamer = Gamer.objects.get(user=request.auth.user)
        try:
            serializer = CreateGameSerializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save(gamer=gamer)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        except ValidationError as ex:
            return Response({'message': ex.args[0]}, status=status.HTTP_400_BAD_REQUEST)
    ```
    
    Instead of making a new instance of the `Game` model, the `request.data` dictionary is passed to the new serializer as the data. The keys on the dictionary     __must__ match what is in the fields on the serializer. After creating the serializer instance, call `is_valid` to make sure the client sent valid data. If the code passes validation, then the `save` method will add the game to the database and add an `id` to the serializer.

3. Try it out again in Postman to see the difference in error handling
4. Update the `EventView`'s create method to check for validation.
