# Generating HTML Reports with Django

## Learning Objectives

After implementing the code in this chapter, you should be able to...

1. Recall that you must use `sqlite3` to use SQL statements in a Django application.
1. Recall that a Django application can return both JSON strings and HTML strings in a response.
1. Understand that both the Django ORM and `sqlite3` can be used in a Django application to query the database.
1. Create a Django project with more than one application in it.
1. Explain that one project is a REST-based API application that returns JSON strings, and the other is an application that returns HTML strings.
1. Perform the steps of writing SQL, constructing the proper data structure from the results, binding that data structure to a Django template, and using the data in the Django template to build a string that returns HTML representations of the data to the client.

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
    1. `connection.py`
1. Create a `levelup/levelupreports/templates` directory.
1. Create a `levelup/levelupreports/urls.py` module. Code for this module is at the end of the chapter.

## Database Connection Module

Use the `pwd` terminal command to get the full, absolute path to the directory that contains the `db.sqlite` file for your project. Copy that path into the `db_path` variable. Make sure you keep `/db.sqlite3` at the end.

```py
class Connection:
    db_path = "/absolute/path/to/levelup/db.sqlite3"
```

Then import it to the views package.

> #### `levelupreports/views/__init__.py`

```py
from .connection import Connection
```

## Games by User View Function

Since this Django application is not using the Django REST Framework plugin, you cannot use ViewSets, or ModelSerializers. Even though you could use the Django ORM - since this is a Django project - you are going to practice your SQL skills again.

Therefore, you are going to be writing plain Python functions that will receive the client request, query the database with SQL, and then use Django templates to send the fully constructed HTML template in response.

> #### `levelupreports/views/users/gamesbyuser.py`

```py
"""Module for generating games by user report"""
import sqlite3
from django.shortcuts import render
from levelupapi.models import Game
from levelupreports.views import Connection


def usergame_list(request):
    """Function to build an HTML report of games by user"""
    if request.method == 'GET':
        # Connect to project database
        with sqlite3.connect(Connection.db_path) as conn:
            conn.row_factory = sqlite3.Row
            db_cursor = conn.cursor()

            # Query for all games, with related user info.
            db_cursor.execute("""
                SELECT
                    g.id,
                    g.title,
                    g.maker,
                    g.game_type_id,
                    g.number_of_players,
                    g.skill_level,
                    u.id user_id,
                    u.first_name || ' ' || u.last_name AS full_name
                FROM
                    levelupapi_game g
                JOIN
                    levelupapi_gamer gr ON g.gamer_id = gr.id
                JOIN
                    auth_user u ON gr.user_id = u.id
            """)

            dataset = db_cursor.fetchall()

            # Take the flat data from the database, and build the
            # following data structure for each gamer.
            #
            # {
            #     1: {
            #         "id": 1,
            #         "full_name": "Admina Straytor",
            #         "games": [
            #             {
            #                 "id": 1,
            #                 "title": "Foo",
            #                 "maker": "Bar Games",
            #                 "skill_level": 3,
            #                 "number_of_players": 4,
            #                 "game_type_id": 2
            #             }
            #         ]
            #     }
            # }

            games_by_user = {}

            for row in dataset:
                # Crete a Game instance and set its properties
                game = Game()
                game.title = row["title"]
                game.maker = row["maker"]
                game.skill_level = row["skill_level"]
                game.number_of_players = row["number_of_players"]
                game.game_type_id = row["game_type_id"]

                # Store the user's id
                uid = row["user_id"]

                # If the user's id is already a key in the dictionary...
                if uid in games_by_user:

                    # Add the current game to the `games` list for it
                    games_by_user[uid]['games'].append(game)

                else:
                    # Otherwise, create the key and dictionary value
                    games_by_user[uid] = {}
                    games_by_user[uid]["id"] = uid
                    games_by_user[uid]["full_name"] = row["full_name"]
                    games_by_user[uid]["games"] = [game]

        # Get only the values from the dictionary and create a list from them
        list_of_users_with_games = games_by_user.values()

        # Specify the Django template and provide data context
        template = 'users/list_with_games.html'
        context = {
            'usergame_list': list_of_users_with_games
        }

        return render(request, template, context)
```

Then import it to the views package.

> #### `levelupreports/views/__init__.py`

```py
from .users.gamesbyuser import usergame_list
```


> **Instructor Note:** You are _**strongly encouraged**_ to take the time to understand the data structure above that is created from the results of the query. This is a common strategy for converting flat data from a SQL data set into a data structure to be used in your application.

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

## Games by User Template

Create a `users` sub-directory in the existing `levelupreports/templates` directory and create the following file and contents.

> #### `levelupreports/templates/users/list_with_games.html`

```jinja
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

Note that you are iterating a list in the variable `usergame_list`. That's the single key in the context dictionary that got bound to this template back in the view.

```py
context = {
    'usergame_list': list_of_users_with_games
}
```

## Report URLs

The last step is to define the URLs that this new application will support.

> #### `levelupreports/urls.py`

```py
from django.urls import path
from .views import usergame_list

urlpatterns = [
    path('reports/usergames', usergame_list),
]
```

The last step is to include these URL patterns in the main `urls.py`, otherwise your app won't support them. Add the code below to the `urlpatterns` list in `levelup/urls.py` module.

```py
path('', include('levelupreports.urls')),
```

## Viewing the Report

Go to Chrome and go to the URL of http://localhost:8000/reports/usergames to view your HTML report. No JSON. No JavaScript or JSX needed. Just a fully-formed HTML document cooked and delivered by Django.
