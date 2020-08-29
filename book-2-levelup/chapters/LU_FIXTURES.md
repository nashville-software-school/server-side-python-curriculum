Karen decides to be benevolent and support Live RPG, table top and MMO games. Create fixture to populate the game type table.

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