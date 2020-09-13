# Gamer Rater ERD

Below are the features and requirements for what resources are needed for this application and their relationships.

* Players can create unique entries for games. Two players cannot create the same game in the system.
* Games must have the following properties on creation:
    * Title
    * Description
    * Designer
    * Year released
    * Number of players
    * Estimated time to play
    * Age recommendation
* A player can assign 1+ categories _(a game can be be described by more than one category)_ to a game.
* Players can upload pictures of a game they are playing.
* Players can rate games.
* Players can write a review of a game.
* Games can be searched, and sorted by category.
* Players can see the average rating of a game _(by you implementing a non-mapped model property)_.
* Players can view all reviews for a game.

Use this information to create an ERD for this project. Visit your instruction team for approval once you believe you have a good diagram.

## Helpful Resources

* [Django ImageField](https://www.geeksforgeeks.org/imagefield-django-models/)
* [How to Upload a File Using Django REST Framework](https://dev.to/djangotricks/how-to-upload-a-file-using-django-rest-framework-1kgf)