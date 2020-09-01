# Karen Cares About Her Users

> Karen decides to be benevolent and support Live RPG, table top and MMO games. Create fixture to populate the game type table.

## Video(s) to Watch First

* [How to Pre Load Data in Database With Django](https://www.youtube.com/watch?v=1_MROM737FI)

## Seeding the Database

"Seeding the database" is a term that developers use to describe the process is inserting some boilerplate data into their databases during development. It gives them some valid data to work with quickly while they try to build new features, or fix bugs.

With Django, you can do that with something called fixtures. A fixture is a file that has JSON formatted data in it. That JSON data is then read by Django, converted into `INSERT INTO` SQL statements, and then executed to get some rows into your database tables.


Be in the Level Up project directory _(~/workspace/python/levelup)_.

```sh
mkdir levelupapi/fixtures
touch levelupapi/fixtures/gametypes.json
```

Open that JSON file and put the following seed data in it.

```json
[
    {
        "model": "levelupapi.gametype",
        "pk": 1,
        "fields": {
            "label": "Table top"
        }
    },
    {
        "model": "levelupapi.gametype",
        "pk": 2,
        "fields": {
            "label": "Role playing"
        }
    },
    {
        "model": "levelupapi.gametype",
        "pk": 3,
        "fields": {
            "label": "MMO"
        }
    }
]
```

Then load that data into the database with the following command.

```sh
python manage.py loaddata gametypes
```

This will generate some `INSERT INTO` SQL statements behind the scenes in Django and create three records in the `levelupapi_gametype` table in your database. Run the following SQL to see them.

```sql
SELECT * FROM levelupapi_gametype;
```

## Default Gamer

To create a full Gamer user account in your database, you need a record in three tables.

1. `auth_user` which is the authentication table that Django builds for you out of the box.
1. `authtoken_token` which also is part of the built-in authentication system of Django.
1. `levelupapi_gamer` which is the table that gets created by Django from your **`Gamer`** model class that you wrote in the `levelup/levelupapi/models/gamer.py` module.

Create the following two files with the corresponding contents.

> #### `levelup/levelupapi/fixtures/users.json`

```json
[
    {
        "model": "auth.user",
        "pk": 1,
        "fields": {
            "password": "pbkdf2_sha256$216000$qMRH8szID7Z8$Vljya2V3XfruOHuvx1hGz9ZyKg4bxbw7rc2WO0gTR7I=",
            "last_login": null,
            "is_superuser": false,
            "username": "me@me.com",
            "first_name": "Steve",
            "last_name": "Brownlee",
            "email": "me@me.com",
            "is_staff": false,
            "is_active": true,
            "date_joined": "2020-08-28T14:51:39.989Z",
            "groups": [],
            "user_permissions": []
        }
    }
]
```

> #### `levelup/levelupapi/fixtures/tokens.json`

```json
[
    {
        "model": "authtoken.token",
        "pk": "fa2eba9be8282d595c997ee5cd49f2ed31f65bed",
        "fields": {
            "user": 1,
            "created": "2020-08-29T13:24:27.172Z"
        }
    }
]
```


> #### `levelup/levelupapi/fixtures/gamers.json`

```json
[
    {
        "model": "levelupapi.gamer",
        "pk": 1,
        "fields": {
            "user": 1,
            "bio": "Me"
        }
    }
]
```

Then execute the following commands.

```sh
python manage.py loaddata users
python manage.py loaddata tokens
python manage.py loaddata gamers
```

Once complete, each of those database tables will have one record in them. You can verify this by connecting to the database and running the following three SQL statements.

```sql
SELECT * FROM auth_user;
SELECT * FROM authtoken_token;
SELECT * FROM levelupapi_gamer;
```

## Practice: Seeding Games

Using the JSON above, see if you can create a `games.json` fixture that seeds the database with two game records that are related to the Gamer record you created above.

## Practice: Seeding Events

Now see if you can seed the database with one event for each of the games that you produced previously.