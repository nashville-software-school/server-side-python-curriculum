# Reviewing a Game

Your first Django ViewSet and React components you should create are for viewing a list of all games in the system, and then a form for creating a game.

## Django Files

1. `raterproject\views\gamereview.py`

## React Files

1. `pages/games/[gameId]/review.js`
1. `components/game/ReviewForm.js`
1. `components/game/Review.js`

## Feature Requirements

When the user is viewing a single game, then there should button labeled "Review Game". When the user clicks on that button, the client URL should change to `/game/{gameId}/review`. This route should render a `<ReviewForm>` component when that URL is active. This form should contain a `<textarea>` element and a "Save" button.

> **Hint**: Use the `useRouter()` hook from NextJS to access the `gameId` variable.

When the user enters a review and clicks the save button, the review text should be sent to the API so that it can be saved in the database.

Once the save is complete, use the `useRouter()` method to redirect the user back to the game that was reviewed.

> **Hint**: Use the `useRouter()` hook in the component.

When the user is viewing a single game, a list of reviews should be displayed beneath the main details of the game.
