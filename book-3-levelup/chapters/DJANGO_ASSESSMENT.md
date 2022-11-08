# Self-Assess Your Django Competencies

## 🐟 Tuna Piano API

This API will allow developers to build applications that recommend songs based on a provided genre. It will manage artists, songs produced by those artists, and the genre for each song.

We'll make millions 💰 💰 💰

There is no authentication needed for this API, so make sure that in your `settings.py` module that the following `AllowAny` setting exists for default persmissions.

```py
REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework.authentication.TokenAuthentication',
    ),
    'DEFAULT_PERMISSION_CLASSES': [
        'rest_framework.permissions.AllowAny',
    ],
}
```

## Vocabulary

When you are done building this project, let one of your coaches know and be prepared to discuss the following learning objectives so that you can ensure that your vocabulary is solid.

1. Understand and explain what a database model is.
2. Understand and explain what a view is.
3. Understand and explain what serializer is.
4. Understand and explain how to expose routes in your API.
5.  Understand and explain how the `related_name` attribute works on database models.
6. Understand and explain a custom property on a model.
7. Understand and explain how to use the ORM to get all rows from a table.
8. Understand and explain how to use the ORM to get single rows from a table.
9. Understand and explain how to use the ORM to get some rows from a table with a filter.
10. Understand and explain how to access request body data.
11. Understand and explain how to access URL query parameters.
12. Be able to load data from a fixture.


### Setup

```sh
cd ~/workspace
mkdir tunapiano
cd tunapiano
pipenv shell
```

Next, install these third-party packages for use in your project.

```sh
pipenv install django autopep8 pylint djangorestframework  pylint-django
```

Then you can create your Django project. Don't forget the `.` at the end of the command

```sh
# DON'T FORGET THE DOT
django-admin startproject tunapiano .
```

Add the linting rules.

```sh
echo '[FORMAT] \n  good-names=i,j,ex,pk\n\n[MESSAGES CONTROL]\n  disable=broad-except,imported-auth-user,missing-class-docstring,no-self-use,abstract-method\n\n[MASTER]\n  disable=C0114,\n' > .pylintrc
```

Open your Workspace Settings and add the following settings to create your `settings.json` file for the project.

```json
"python.linting.pylintArgs": [
    "--load-plugins=pylint_django",
    "--django-settings-module=tunapiano.settings",
],
```

Create a `.gitignore` file and generate the content for it by running this command in the terminal.

```sh
curl -L -s 'https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore' > .gitignore
```

Now create your API project.

```sh
python3 manage.py startapp tunaapi
```

Create the initial directories and package files.

```sh
rm tunaapi/models.py tunaapi/views.py
mkdir tunaapi/models tunaapi/views
touch tunaapi/models/__init__.py tunaapi/views/__init__.py
```

Make sure that the following apps are added to the `INSTALLED_APPS` in your `settings.py` module.

```py
    'rest_framework',
    'rest_framework.authtoken',
    'tunaapi',
```

Now you are ready to build your API. Read the requirements below.

### 🎶 Songs

1. Create a new song
2. List all songs with genre and artist information embedded
3. Get a single song with genre and artist information embedded
4. List songs assigned to a specific genre
5. List songs assigned to a specific artist

### 👩🏾‍🎤 Artists

1. Create a new artist
2. Get a single artist. The response should include the total number of songs in the database for the artist.
3. List all artists.

## Data Design

### Artists

The following information should be captured for each artist.

1. Name
2. Age
3. Bio

### Songs

The following information should be captured for each song.

1. Title
2. Artist
3. Genre
4. Album name
5. Length

### Genres

The genre model only needs to have the name of the genre on it.

## JSON Responses

Set up your serializers to produce the following JSON responses for getting songs and artists.

## Song

```json
{
    "id": 1,
    "title": "Song Title",
    "album": "Album Title",
    "length": 342,
    "genre": {
        "description": "Pop"
    },
    "artist": {
        "name": "Yerena Gonzalez"
    }
}
```

## Artist

```json
{
    "id": 1,
    "name": "Yerena Gonzalez",
    "age": 26,
    "bio": "Accusamus maxime sed illo doloribus minus. Quaerat et sed et. Harum consequatur hic ut magnam consequatur labore culpa tempore.",
    "songs": [
        {
            "id": 1,
            "title": "Song Title",
            "album": "Album Title"
        }
    ]
}
```
