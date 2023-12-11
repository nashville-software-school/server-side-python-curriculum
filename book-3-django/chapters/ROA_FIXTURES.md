# Fixtures

| Term | Definition |
|--|--|
| Fixture | JSON files that contain some data for your database. Useful for initial creation of a development database, or for testing. |

In this chapter, you are going to set up your project with some fixtures so that you can provide some [initial, or seed, data](https://docs.djangoproject.com/en/4.1/howto/initial-data/) for your database, without the need to write any `INSERT INTO` statements in a SQL file.

## Setup

Be in the `rockapi` directory and run the following commands to create the fixtures directory and the JSON files you will need.

```sh
mkdir fixtures
cd fixtures
touch types.json
touch rocks.json
```

### Types Data

Copy the following JSON into the `types.json` file.

<details>
<summary>Expand to get the JSON data</summary>

```json
[
    {
        "model": "rockapi.type",
        "pk": 1,
        "fields": {
            "label": "Metamorphic"
        }
    },
    {
        "model": "rockapi.type",
        "pk": 2,
        "fields": {
            "label": "Igneous"
        }
    },
    {
        "model": "rockapi.type",
        "pk": 3,
        "fields": {
            "label": "Sedimentary"
        }
    },
    {
        "model": "rockapi.type",
        "pk": 4,
        "fields": {
            "label": "Shale"
        }
    },
    {
        "model": "rockapi.type",
        "pk": 5,
        "fields": {
            "label": "Basalt"
        }
    }
]
```
</details>

### Rocks Data

Copy the following JSON into the `rocks.json` file.

<details>
<summary>Expand to get the JSON data</summary>

```json
[
    {
        "model": "rockapi.rock",
        "pk": 1,
        "fields": {
            "user": 1,
            "type": 3,
            "name": "Ernestina",
            "weight": 1.3
        }
    },
    {
        "model": "rockapi.rock",
        "pk": 2,
        "fields": {
            "user": 1,
            "type": 1,
            "name": "Orpha",
            "weight": 0.5
        }
    },
    {
        "model": "rockapi.rock",
        "pk": 3,
        "fields": {
            "user": 1,
            "type": 5,
            "name": "Sasha",
            "weight": 0.29
        }
    }
]
```
</details>

## Load Your Fixtures

In your terminal make sure you back in the main `rock-of-ages` _(or whatever you named your repo)_ directory. Then run the following commands to load that initial data into your database.

```sh
python3 manage.py loaddata types rocks
```

If everything was done correctly, you will see the following output.

```txt
Installed 8 object(s) from 2 fixture(s)
```

## Get Your New Data

Now open your API client _(Postman, Insomnia, etc.)_ and make two requests and verify that you get those types and rocks from your API.

- GET http://localhost:8000/types
- GET http://localhost:8000/rocks

## Video Walkthrough

Here is a 2:03 minute walkthrough of implementing the code with explanations.

[<img src="./images/video-play-icon.gif" height="75rem" />](https://watch.screencastify.com/v/H0elzOxahxsHsTk8lZjJ)
