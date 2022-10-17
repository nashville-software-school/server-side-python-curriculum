# Serializers Are Shallow. Add Some Depth.

Right now the `GET` methods do not include any nested data, only the foreign key. Embedding that data is only 1 line of code!

Take a look at the response for getting all the games. Notice that `game_type` is just the id of the type. Back in the `GameSerializer` add this to the end of `Meta` class tabbed to the same level as the `fields` property

```py
depth = 1
```
And that’s it! Back in postman, get all the games again to see the difference

### Try it out

Add the depth to the `EventSerializer`. What happens if you set the depth equal to 2?
