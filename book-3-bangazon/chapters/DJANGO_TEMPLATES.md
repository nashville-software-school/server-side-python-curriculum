# Generating HTML Reports with Django

## Learning Objectives

After implementing the code in this chapter, you should be able to...

1. Recall that a Django application can return both JSON strings and HTML strings in a response.
1. Understand that both the Django ORM and `sql` can be used in a Django application to query the database.
1. Create a Django project with more than one application in it.
1. Explain that one project is a Django Rest Framework API application that returns JSON strings, and the other is a Django application that returns HTML strings.
1. Execute SQL using the django connection
1. Bind data to a Django template
1. Use the template context to loop over data in the html


## Resources
1. [Django Views](https://docs.djangoproject.com/en/3.2/topics/class-based-views/intro/)
1. [Python Comprehensions](https://www.geeksforgeeks.org/comprehensions-in-python/)
1. [Executing SQL within Django](https://docs.djangoproject.com/en/3.2/topics/db/sql/#executing-custom-sql-directly)
1. [Django Templates](https://docs.djangoproject.com/en/3.2/topics/templates/)

## Setup

Be in your LevelUp project directory.

1. Create a new application for producing HTML reports.
    ```sh
    python3 manage.py startapp levelupreports
    ```
1. Add `levelupreports` to your installed apps in the `settings.py` module.
1. Delete the `models.py` and `views.py` modules in the  application.
1. Create a `levelup/levelupreports/views` directory and create the following two modules in it.
    1. `__init__.py`
    1. `helpers.py`
1. Create a `levelup/levelupreports/templates` directory.
1. Create a `levelup/levelupreports/urls.py` module. Code for this module is at the end of the chapter.

## Database Helper Functions
Back in book 1, we were using the sqlite3 module to connect to the database and return dictionary-like objects from the database. This time around since we are using django to connect to the database we'll need to write a function that takes the output from the db_cursor.fetchall function and returns a list of dictionaries. Add the following code to the `helpers.py` file


```py
def dict_fetch_all(cursor):
    """Return all rows from a cursor as a list of dictionaries"""
    columns = [col[0] for col in cursor.description]
    return [
        dict(zip(columns, row))
        for row in cursor.fetchall()
    ]

```



## Games by User View Class
This should look somewhat familiar to you. There's a class view with a get method. Instead of `list`, `retrieve`, `update`, and `destroy` like the Rest Framework views have, basic django views have `get`, `post`, `put`, and `delete`. Notice that all the imports are coming from `django` instead of `rest_framework`. That is how you can tell this will be a django view. While we could still use the `ORM` to retrieve data from the database, `SQL` is an important tool to continue practicing.

Fill in the correct sql and dictionary code in the starter below:

> #### `levelupreports/views/users/gamesbyuser.py`

```py
"""Module for generating games by user report"""
from django.shortcuts import render
from django.db import connection
from django.views import View

from levelupreports.views.helpers import dict_fetch_all


class UserGameList(View):
    def get(self, request):
        with connection.cursor() as db_cursor:

            # TODO: Write a query to get all games along with the gamer first name, last name, and id
            db_cursor.execute("""
            
            """)
            # Pass the db_cursor to the dict_fetch_all function to turn the fetch_all() response into a dictionary
            dataset = dict_fetch_all(db_cursor)

            # Take the flat data from the dataset, and build the
            # following data structure for each gamer.
            # This will be the structure of the games_by_user list:
            #
            # [
            #   {
            #     "id": 1,
            #     "full_name": "Admina Straytor",
            #     "games": [
            #       {
            #         "id": 1,
            #         "title": "Foo",
            #         "maker": "Bar Games",
            #         "skill_level": 3,
            #         "number_of_players": 4,
            #         "game_type_id": 2
            #       },
            #       {
            #         "id": 2,
            #         "title": "Foo 2",
            #         "maker": "Bar Games 2",
            #         "skill_level": 3,
            #         "number_of_players": 4,
            #         "game_type_id": 2
            #       }
            #     ]
            #   },
            # ]

            games_by_user = []

            for row in dataset:
                # TODO: Create a dictionary called game that includes 
                # the name, description, number_of_players, maker,
                # game_type_id, and skill_level from the row dictionary
                game = {
                    
                }
                
                # See if the gamer has been added to the games_by_user list already
                user_dict = None
                for user_game in games_by_user:
                     if user_game['gamer_id'] == row['gamer_id']:
                         user_dict = user_game
                
                
                if user_dict:
                    # If the user_dict is already in the games_by_user list, append the game to the games list
                    user_dict['games'].append(game)
                else:
                    # If the user is not on the games_by_user list, create and add the user to the list
                    games_by_user.append({
                        "gamer_id": row['gamer_id'],
                        "full_name": row['full_name'],
                        "games": [game]
                    })
        
        # The template string must match the file name of the html template
        template = 'users/list_with_games.html'
        
        # The context will be a dictionary that the template can access to show data
        context = {
            "usergame_list": games_by_user
        }

        return render(request, template, context)

```

Then import it to the views package.

> #### `levelupreports/views/__init__.py`

```py
from .users.gamesbyuser import UserGameList
```


## Django Templates, the New JSX

Django templates are very much like JSX in React, and they serve the exact same purpose. HTML interspersed with interpolations to inject the values of variables where needed. The syntax is slightly different than JSX.

Interpolation for a single variable is identical.

```jinja
{{ user.full_name }}
```

However, in a Django template, you can use Python `for..in` loops instead of having to rely on array methods like you did in JSX.

```jinja
{% for games in games %}
    {{ game.title }}
{% endfor %}
```

You can even use `if/then` blocks, although you don't need it for this template. In JSX, you needed to use a JavaScript ternary statement to have conditional output.

For more information take a look at the docs, [Django Templates](https://docs.djangoproject.com/en/3.2/topics/templates/)

## Games by User Template

Create a `users` sub-directory in the existing `levelupreports/templates` directory and create the following file and contents.

> #### `levelupreports/templates/users/list_with_games.html`

```html
{% load static %}
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>LevelUp Reports</title>
  </head>
  <body>
    <h1>User Games</h1>

    {% for user in usergame_list %}
        <h2>{{ user.full_name }}</h2>
        <ol>
            {% for game in user.games %}
            <li>
                Title: {{ game.title }}
            </li>
            {% endfor %}
        </ol>
    {% endfor %}
  </body>
</html>
```

Note that you are iterating over the `usergame_list` list. That's the single key in the context dictionary that was bound to this template in the view.

```py
context = {
    'usergame_list': games_by_user
}
```

## Report URLs

The last step is to define the URLs that this new application will support.

> #### `levelupreports/urls.py`

```py
from django.urls import path
from .views import UserGameList

urlpatterns = [
    path('reports/usergames', UserGameList.as_view()),
]
```

The last step is to include these URL patterns in the main `urls.py`, otherwise your app won't support them. Add the code below to the `urlpatterns` list in `levelup/urls.py` module.

```py
path('', include('levelupreports.urls')),
```

## Viewing the Report

Go to Chrome and go to the URL of http://localhost:8000/reports/usergames to view your HTML report. No JSON. No JavaScript or JSX needed. Just a fully-formed HTML document cooked and delivered by Django.
