# Reviewing a Game

Next, you will add the ability for an authenticated user to review an existing game.

## Feature Requirements

When the user is viewing a single game, then there should button labeled "Review Game". When the user clicks on that button, the client URL should change to `/game/{gameId}/review`. A `<Route exact path="/games/:gameId(\d+)/review">` in **`ApplicationViews`** should be set up to render a `<ReviewForm>` component when that URL is active. This form should contain a `<textarea>` element and a "Save" button.

When the user enters a review and clicks the save button, the review text should be sent to the API so that it can be saved in the database.

Once the save is complete, redirect the user back to the game that was reviewed.

When the user is viewing a single game, a list of reviews should be displayed beneath the main details of the game.
