# Reviewing a Game

Your first Django ViewSet and React components you should create are for viewing a list of all games in the system, and then a form for creating a game.

## Django Files

1. `raterproject\views\gamereview.py`

## React Files

1. `components/game/ReviewForm.js`
1. `components/game/Review.js`

## Feature Requirements

When the user is viewing a single game, then there should button labeled "Review Game". When the user clicks on that button, a form should be presented to the user that has a `<textarea>` element and a "Save" button.

When the user enters a review and clicks the save button, the review text should be sent to the API so that it can be saved in the database.

Once the save is complete, redirect the user back to the game that was reviewed.

When the user is viewing a single game, a list of reviews should be displayed beneath the main details of the game.
