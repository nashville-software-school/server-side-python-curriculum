# Sorting Queries

In this chapter, you are going to allow a game to sort the list of all games by one of the following properties.

1. Year released
1. Estimated time to play
1. Designer

On the game list, provide a `<select>` element with those three options. When the user chooses one, query the API with a query string parameter at the end of the URL.

For example, if the gamer chose "Year released", then your request URL might look like this.

http://localhost:8000/games?orderby=year

If the gamer chose Designer, then it might look like this.

http://localhost:8000/games?orderby=designer

## Using `order_by`

Read the official docuentation for [using order_by](https://docs.djangoproject.com/en/3.1/ref/models/querysets/#order-by) when building a query set with the Django ORM.

1. In your ViewSet, get the `orderby` query string parameter value from the URL _(review previous chapter to see how to get query string parameter values)_.
1. Pass that value to the `order_by` method.