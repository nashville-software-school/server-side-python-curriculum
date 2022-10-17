## Handling 404 with Try/Except

What happens if you try to get a game type that doesn’t exist? Send the following with your API client.

GET http://localhost:8000/gametypes/100

What error it displayed in the response? It’s a pretty ugly error that isn’t very useful.

We can change that by adding a try/except block around the `GameType.obejcts.get` method call. Update the retrieval method with this code:
```py
try:
    game_type = GameType.objects.get(pk=pk)
    serializer = GameTypeSerializer(game_type)
    return Response(serializer.data)
except GameType.DoesNotExist as ex:
    return Response({'message': ex.args[0]}, status=status.HTTP_404_NOT_FOUND)
```

With this change, if the code inside the try block throws a `DoesNotExist` then the server will respond with a nicer 404 message. Try to get a game type that doesn’t exist again to see the difference.

### Try it out

Add the try/except block to the other `retrieve` methods in your API and then perform a `GET` request for an `id` that you know doesn't exist for each one.