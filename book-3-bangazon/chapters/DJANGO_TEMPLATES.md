# Generating HTML Reports with Django

## Learning Objectives

After implementing the code in this chapter, you should be able to...

1. Recognize that you can use `sqlite3` and raw SQL in a Django application.
1. Recall that a Django application can return both JSON strings and HTML strings in a response.
1. Understand that both the Django ORM and `sqlite3` can be used in a Django application to query the database.
1. Create a Django project with more than one application in it.
1. Explain that one project is a REST-based API application that returns JSON strings, and the other is an application that returns HTML strings.
1. Perform the steps of writing SQL, constructing the proper data structure from the results, binding that data structure to a Django template, and using the data in the Django template to build a string that displays HTML representations of the data.

## Setup

Be in your LevelUp project directory.

1. Create a new application for producing HTML reports.
    ```sh
    python manage.py startapp levelupreports
    ```
1. Add `levelupreports` to your installed apps in the `settings.py` module.
1. Delete the `models.py` and `views.py` modules in the  application.
1. Create a `views` directory in the application and create the following two modules in it.
    1. `__init__.py`
    1. `connection.py`
1. Create a `templates` directory in the application.
1. Create a `urls.py` module in the report application, and add the following code.

## Database Connection Module

Use the `pwd` terminal command to get the full, absolute path to the directory that contains the `db.sqlite` file for your project. Copy that path into the `db_path` variable. Make sure you keep `/db.sqlite3` at the end.

```py
class Connection:
    db_path = "/absolute/path/to/levelup/db.sqlite3"
```

## Games by User View Function

> #### `levelupreports/views/users/gamesbyuser.py`

```py
import sqlite3
from django.shortcuts import render
from levelupapi.models import Game
from levelupreports.views import Connection


def usergame_list(request):
    if request.method == 'GET':
        with sqlite3.connect(Connection.db_path) as conn:
            conn.row_factory = sqlite3.Row
            db_cursor = conn.cursor()

            db_cursor.execute("""
                SELECT
                    g.id,
                    g.title,
                    g.maker,
                    g.gametype_id,
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
            games_by_user = {}

            for row in dataset:
                game = Game()
                game.title = row["title"]
                game.maker = row["maker"]
                game.skill_level = row["skill_level"]
                game.number_of_players = row["number_of_players"]
                game.gametype_id = row["gametype_id"]

                uid = row["user_id"]
                if uid in games_by_user:
                    games_by_user[uid]['games'].append(game)
                else:
                    games_by_user[uid] = {}
                    games_by_user[uid]["id"] = uid
                    games_by_user[uid]["full_name"] = row["full_name"]
                    games_by_user[uid]["games"] = [game]

        # Get only the values from the dictionary and create a list from them
        list_of_users_with_games = games_by_user.values()

        # Specify the HTML template and provide data context
        template = 'users/list_with_games.html'
        context = {
            'usergame_list': list_of_users_with_games
        }

        return render(request, template, context)
```

## Games by User Template

Create a `users` sub-directory in the existing `levelupreports/templates` directory.

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

## Report URLs

```py
from django.urls import path
from .views import *

app_name = "levelupreporting"

urlpatterns = [
    path('reports/usergames', usergame_list),
]
```