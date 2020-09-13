# Rating Games

When you display a single game, provide a mechanism for a user to review a game on a scale of 1-10.

* Radio buttons
* Slider control
* Dropdown
* Input text box for manual entry

Plenty of options for you to choose from. Just make sure that the user can only specify a number from 1 to 10.

## Displaying Rating

When you show the details of a game, you are not going to list every individual rating given by users. You will need to show an average rating. Since the average is not stored in the database, but rather calculated each time, you will need a non-mapped property named `average_rating` on the **`Game`** model in your API.

Then, any time a game is requested - either a single one, or the entire list - you need to calculate the average rating of each game and set the value of the non-mapped property.

```py
@property
def average_rating(self):
    """Average rating calculated attribute for each game"""
    ratings = GameRating.objects.filter(game=self)

    # Sum all of the ratings for the game
    total_rating = 0
    for rating in ratings:
        total_rating += rating.rating

    # Calculate the averge and return it.
    # If you don't know how to calculate averge, Google it.
```