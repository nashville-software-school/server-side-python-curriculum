# Karen Cares About Her Users

> You receive a phone call from Karen, sorry, Kari, on a Thursday morning.
>
> "Hello?"
>
> "Hi, this is Kari! I have an update for you." She seems very nervous.
>
> "Ok," you reply. "Let me grab my notes."
>
> You reach into your backpack on the other side of the couch where you are sitting and pull out your note journal, and decide on the slender green pen for today's notes.
>
> You click the pen and say, "Ok, I'm ready, Kari."
>
> "I was talking to some friends earlier in the week, and apparently many of them play games on their computers. I had no idea. Susan... she's a friend who watches my cats sometimes... well, she watches some because Sammy and Jasper don't like her. If I need someone to watch Sammy and Jasper, I can usually count on Helen. You see, Helen has cats, too, but not as many as me, so..."
>
> You sigh silently and listen to a 10-minute lecture about which of Karen's friends have particularly meaningful relationhips with each one of her myriad cats.
>
> "...and since they all told me that they play an online game called Fever Fantasy, I decided that I should allow people to create games and events for things other than board games."
>
> "Sure, no problem, Kari!" You write down that you need to add more game types to the database.
>
> "What about role-playing games?"
>
> "Uhhh, I don't think I want those kinds of people using my software," she says haughtily.
>
> "I'm not sure what you mean. I have plenty of friends who play role-playing games like Dungeons & Dragons and Shadowrun."
>
> There is a moment's pause and Karen replies, "Oooohhh, those role-playing games. Yes, I think my niece and nephew do that. They dress up like knights and wizards and go to some parks to pretend."
>
> After a short discussion, you both agree that the "software" will allow people to create board games, role-playing games, and MMO games.

## Learning Objectives

* You should be able to explain what "seeding a database table" means.
* You should be able to implement a JSON format fixture for a database table.
* You should be able to apply a JSON fixture to get data inserted into a database table.
* You should be able to implement fixtures in the correct order, based on the dependencies of your tables.

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
            "label": "Board game"
        }
    },
    {
        "model": "levelupapi.gametype",
        "pk": 2,
        "fields": {
            "label": "Role-playing game"
        }
    },
    {
        "model": "levelupapi.gametype",
        "pk": 3,
        "fields": {
            "label": "MMO game"
        }
    }
]
```

Then load that data into the database with the following command.

```sh
python3 manage.py loaddata gametypes
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
python3 manage.py loaddata users
python3 manage.py loaddata tokens
python3 manage.py loaddata gamers
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