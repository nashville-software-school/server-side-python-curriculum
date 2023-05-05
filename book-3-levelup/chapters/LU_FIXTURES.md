# Carrie Cares About Her Users

> You receive a phone call from Carrie, on a Thursday morning.
>
> "Hello?"
>
> "Hi, this is Carrie! I have an update for you." She seems very nervous.
>
> "Ok," you reply. "Let me grab my notes."
>
> You reach into your backpack on the other side of the couch where you are sitting and pull out your note journal, and decide on the slender green pen for today's notes.
>
> You click the pen and say, "Ok, I'm ready, Carrie."
>
> "I was talking to my granddaughter the other day. She was telling me about role-playing games that aren't board games. I think it was called, Caves and Chimeras? Anyway, I'd like that to be one of the game type options on the website"
> "Sure, no problem, Carrie!" You write down that you need to add more game types to the database.
>
> "Then, my other grandchild was talking to their friends about organizing a time to play an online game together. So I wondered if that sort of game would work for this as well?"
>
> After a quick pause, you can't think of any reason an online game wouldn't work, "That shouldn't be a problem to implement. So users will be able to create board games, role-playing games, and MMO games?"
>
> "That sounds wonderful! I can't wait to show my grand kids what I've been up to."

## Learning Objectives

* You should be able to explain what "seeding a database table" means.
* You should be able to implement a JSON format fixture for a database table.
* You should be able to apply a JSON fixture to get data inserted into a database table.
* You should be able to implement fixtures in the correct order, based on the dependencies of your tables.

## Learning Resources

* Documentation: [Providing initial data for models](https://docs.djangoproject.com/en/3.1/howto/initial-data/)
* Video: [How to Pre Load Data in Database With Django](https://www.youtube.com/watch?v=1_MROM737FI)

## Seeding the Database

"Seeding the database" is a term that developers use to describe the process is inserting some boilerplate data into their databases during development. It gives them some valid data to work with quickly while they try to build new features, or fix bugs.

With Django, you can do that with something called fixtures. A fixture is a file that has JSON formatted data in it. That JSON data is then read by Django, converted into `INSERT INTO` SQL statements, and then executed to get some rows into your database tables.

### 1. TODO: Create Game Types

Be in the levelup server directory _`~/[...]/levelup-server`_

```bash
mkdir levelupapi/fixtures
touch levelupapi/fixtures/game_types.json
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
python3 manage.py loaddata game_types
```

This will generate some `INSERT INTO` SQL statements behind the scenes in Django and create three records in the `levelupapi_gametype` table in your database. Run the following SQL to see them.

```sql
SELECT * FROM levelupapi_gametype;
```

## Default Gamer

### 2. TODO: Create Gamer
To create a full Gamer user account in your database, you need a record in the Gamer table.

1. `levelupapi_gamer` - *which is the table that gets created by Django from your **`Gamer`** model class that you wrote in the `levelup-server/levelupapi/models/gamer.py` module.*

Create the following file with the corresponding contents.

> #### `levelup-server/levelupapi/fixtures/gamers.json`

```json
[
    {
        "model": "levelupapi.gamer",
        "pk": 1,
        "fields": {
            "uid": 1,
            "bio": "Me"
        }
    }
]
```

Then execute the following command.

```sh
python3 manage.py loaddata gamers
```

Once complete, your Gamer table will have one record in them. You can verify this by connecting to the database and running the following SQL statement.

```sql
SELECT * FROM levelupapi_gamer;
```

## Practice: Seeding Games

Using the JSON above, see if you can create a `games.json` fixture that seeds the database with two game records that are related to the Gamer record you created above.

## Practice: Seeding Events

Now see if you can seed the database with one event for each of the games that you produced previously.
