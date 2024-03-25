# Searching for Games

When the gamer is viewing a list of all games, then you should provide, at the top of the list, an input field where the gamer can type in a search string. When the gamer presses the return key, a request to the API should be initiated with a query string parameter.

For example, if the user typed in "catan" and then pressed the return key, the request URL would look like this.

http://localhost:8000/games?q=catan

* `q` is the parameter
* `catan` is the value of the parameter

## Game ViewSet

### Query String Parameters

Here is how you would get the string of "catan" if the client requested the URL above.

```py
search_text = self.request.query_params.get('q', None)
```

### Q Function

You can use the oddly named `Q` function to see if more that one property of a model contains a certain substring.

> #### `views/game.py`

```py
from django.db.models import Q
```

### Getting Matching Games

Then, if the value of `search_text` is not `None`, get all games that where the title, or the description, or the designer name has the query string parameter's value in it.

> #### `views/game.py`

```py
Game.objects.filter(
    Q(title__contains=search_text) |
    Q(description__contains=search_text) |
    Q(designer__contains=search_text)
)
```