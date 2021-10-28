# Editing Games

## Learning Objectives

* You should be able to explain which HTTP method is used by the client to trigger an update request.
* You should be able to identify which method on a ViewSet is invoked when the client has requested a change in state for a resource.

## API View Code

We've already written the `update` method for Games. Take a quick look to see what information that method is looking for from the front end. Here's the lines of code to focus on:
```py
game = Game.objects.get(pk=pk)
game.title = request.data["title"]
game.maker = request.data["maker"]
game.number_of_players = request.data["numberOfPlayers"]
game.skill_level = request.data["skillLevel"]
game.gamer = gamer

game_type = GameType.objects.get(pk=request.data["gameTypeId"])
game.game_type = game_type
```
All the keys being accessed on the `request.data` will need to be present when the client makes an update request. The client will need to send an object that looks like this:
```js
{
    title: "Game title",
    maker: "Game Maker",
    numberOfPlayers: 3,
    skillLevel: 2,
    gameTypeId: 1
}
```

## React Practice

Currently, the `EventForm` and `GameForm` components are only for creating a new game. Either create `UpdateEventForm` and `UpdateGameForm` components or rework the existing form components to update the game or event. You'll need:
1. A react route that renders a form
1. The form should be filled out with the existing data
1. When changes are made in the form the state of the component updates
1. When the submit button is clicked, it should make a `PUT` request to the correct resource with the updated data in the body
1. After the fetch call is resolved, the page should route to the game/event list page
