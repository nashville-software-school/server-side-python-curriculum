
# Writing the `destroy` method
The `destroy` method handles `DELETE` requests to the view. This will be how we delete a row from the database. 

## The code
Just like the `retrieve` and `update` methods, the `destroy` method take the `pk` as an argument. We’ll use that `pk` to get the single object, then call the `delete` from the ORM to remove it from the database. The response will send back a `204 `status. Add the following to the `GameView` making sure the tabbing lines up correctly.

```python
def destroy(self, request, pk):
    game = Game.objects.get(pk=pk)
    game.delete()
    return Response(None, status=status.HTTP_204_NO_CONTENT)
        
```

### Postman
Try deleting a game in postman. Since this method takes a pk in the parameters, the url must include a `pk` after the resource. Make a `DELETE` request to `http://localhost:8000/games/1` to delete the game with an id of 1. Get the list of all games to verify that it was removed.

## On Your Own
Write the `destroy` method for the `EventView`

# React Code
Let’s add a “Delete” button to the event and game lists.
1. Add a “Delete” button inside the `events` and `games` map in each list component
2.  Create a `deleteGame` and `deleteEvent` function that takes an id parameter and makes a fetch call for a `DELETE` request to the right resource. The `id` parameter from the function should be used in the fetch url.
3. `onClick` of the button should call the `DELETE` fetch function and pass in the object’s id. After the `DELETE` function runs, then the component should get the list again and update the state.
4. Try it out in the browser to see if the delete button works and the list updates.