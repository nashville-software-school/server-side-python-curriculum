## Validating Post Requests
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
    # add this line at the top with the other imports
    from django.core.exceptions import ValidationError

    # this will replace the previous create method
    def create(self, request):
        """Handle POST operations

        Returns:
            Response -- JSON serialized game instance
        """
        gamer = Gamer.objects.get(user=request.auth.user)
        serializer = CreateGameSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save(gamer=gamer)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    ```
    
    Instead of making a new instance of the `Game` model, the `request.data` dictionary is passed to the new serializer as the data. The keys on the dictionary     __must__ match what is in the fields on the serializer. After creating the serializer instance, call `is_valid` to make sure the client sent valid data. If the code passes validation, then the `save` method will add the game to the database and add an `id` to the serializer.

3. Try it out again in Postman to see the difference in error handling
4. Update the `EventView`'s create method to check for validation.
