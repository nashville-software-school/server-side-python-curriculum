# Helpful Bash Script

In this chapter, you are going to set up your project with a bash script that contains commands you can have a fresh start for your database and fixtures whenever you want.

## Setup

Be in the `digestapi` directory and run the following commands to create the fixtures directory and the JSON files you will need.

```sh
mkdir fixtures
cd fixtures
touch tokens.json
touch users.json
```

### Token Data

Copy the following JSON into the `tokens.json` file.

<details>
<summary>Expand to get the JSON data</summary>

```json
[
    {
        "model": "authtoken.token",
        "pk": "06787add96eb3264080015997720cb0877b40f90",
        "fields": {
            "user": 6,
            "created": "2022-10-21T21:19:25.057Z"
        }
    },
    {
        "model": "authtoken.token",
        "pk": "0be249c88238743e5b4a7ac370b5145730c28e20",
        "fields": {
            "user": 1,
            "created": "2022-10-21T21:15:55.928Z"
        }
    },
    {
        "model": "authtoken.token",
        "pk": "8b44b69d17de6e7e81bede339e8fd997369f8819",
        "fields": {
            "user": 5,
            "created": "2022-10-21T21:18:55.902Z"
        }
    },
    {
        "model": "authtoken.token",
        "pk": "a165c6136019e8c4246c1a31856234d33ce476da",
        "fields": {
            "user": 4,
            "created": "2022-10-21T21:18:13.109Z"
        }
    },
    {
        "model": "authtoken.token",
        "pk": "d74b97fbe905134520bb236b0016703f50380dcf",
        "fields": {
            "user": 2,
            "created": "2022-10-21T21:16:33.976Z"
        }
    },
    {
        "model": "authtoken.token",
        "pk": "ec7ddcc665035a3adeaa80ed8f812bfe3ef5b5f4",
        "fields": {
            "user": 3,
            "created": "2022-10-21T21:17:24.482Z"
        }
    }
]
```
</details>

### User Data

Copy the following JSON into the `users.json` file.

> 🧨 The passwords have been encrypted for secure storage in the database, but each user's password is their last name.

<details>
<summary>Expand to get the JSON data</summary>

```json
[
    {
        "model": "auth.user",
        "pk": 1,
        "fields": {
            "password": "pbkdf2_sha256$320000$skKMaZQjJwGMIJO1MmeaoP$68b2U4VFPL1ZQYgYmM7sIJUWPDhKCrAJOrdz4MWnLq4=",
            "last_login": null,
            "is_superuser": false,
            "username": "ryan@ryantanay.com",
            "first_name": "Ryan",
            "last_name": "Tanay",
            "email": "ryan@ryantanay.com",
            "is_staff": false,
            "is_active": true,
            "date_joined": "2022-10-21T21:15:55.764Z",
            "groups": [],
            "user_permissions": []
        }
    },
    {
        "model": "auth.user",
        "pk": 2,
        "fields": {
            "password": "pbkdf2_sha256$320000$6caQGznxTT5xOWckvjT6QO$YZTdqhVzw5XIXUcA2TrQsZuC4SJGBeFc2OYOIz6j8Lk=",
            "last_login": null,
            "is_superuser": false,
            "username": "meg@ducharme.com",
            "first_name": "Meg",
            "last_name": "Ducharme",
            "email": "meg@ducharme.com",
            "is_staff": true,
            "is_active": true,
            "date_joined": "2022-10-21T21:16:33.812Z",
            "groups": [],
            "user_permissions": []
        }
    },
    {
        "model": "auth.user",
        "pk": 3,
        "fields": {
            "password": "pbkdf2_sha256$320000$NKseENHvY06F1AIu2RdtPX$mEuwkQRhvscNYW9ORA68BddrY96oVevnyLz6szhmrO4=",
            "last_login": null,
            "is_superuser": false,
            "username": "jenna@solis.com",
            "first_name": "Jenna",
            "last_name": "Solis",
            "email": "jenna@solis.com",
            "is_staff": false,
            "is_active": true,
            "date_joined": "2022-10-21T21:17:24.322Z",
            "groups": [],
            "user_permissions": []
        }
    },
    {
        "model": "auth.user",
        "pk": 4,
        "fields": {
            "password": "pbkdf2_sha256$320000$d3OTZFUe5DZje6Kb6rm7zv$5oKmFOAQ2WtJQJ+FCT4tXnkbsL60zQN0OTM4nPQQ69A=",
            "last_login": null,
            "is_superuser": false,
            "username": "bryan@nilson.com",
            "first_name": "Bryan",
            "last_name": "Nilson",
            "email": "bryan@nilson.com",
            "is_staff": false,
            "is_active": true,
            "date_joined": "2022-10-21T21:18:12.946Z",
            "groups": [],
            "user_permissions": []
        }
    },
    {
        "model": "auth.user",
        "pk": 5,
        "fields": {
            "password": "pbkdf2_sha256$320000$L9WyeeE95squbRZelePsZf$XayBzPujv5CeAnmIzcLL0orBqE3qDpJLuQsy9zOM5rc=",
            "last_login": null,
            "is_superuser": false,
            "username": "emily@lemmon.com",
            "first_name": "Emily",
            "last_name": "Lemmon",
            "email": "emily@lemmon.com",
            "is_staff": true,
            "is_active": true,
            "date_joined": "2022-10-21T21:18:55.741Z",
            "groups": [],
            "user_permissions": []
        }
    },
    {
        "model": "auth.user",
        "pk": 6,
        "fields": {
            "password": "pbkdf2_sha256$320000$iU8LQX1Y1DxUjhddsV7FR7$AAvT4VAaY7v7hiOGX8/rnuoAkZnj1joW5WOt6kbGC9Q=",
            "last_login": null,
            "is_superuser": false,
            "username": "tyler@hilliard.com",
            "first_name": "Tyler",
            "last_name": "Hilliard",
            "email": "tyler@hilliard.com",
            "is_staff": true,
            "is_active": true,
            "date_joined": "2022-10-21T21:19:24.892Z",
            "groups": [],
            "user_permissions": []
        }
    }
]
```
</details>

## Book Fixtures

Now you create a `books.json` file and fill it with JSON representations of books to be loaded into the database.

## Database Seeding Bash Script

Make sure you are back in the main project directory and not in either app directory.

1. Create a file named `seed_database.sh`.
2. Copy pasta the following content into it.
   ```sh
   #!/bin/bash

   rm db.sqlite3
   rm -rf ./digestapi/migrations
   python3 manage.py migrate
   python3 manage.py makemigrations digestapi
   python3 manage.py migrate digestapi
   python3 manage.py loaddata users
   python3 manage.py loaddata tokens
   python3 manage.py loaddata books
   ```
3. Run the following command in your terminal. It makes the file an [executable script](https://linuxhandbook.com/make-file-executable/).
    ```sh
    chmod u+x ./seed_database.sh
    ```

## Seed Your Database

Now you can run that script any time you want to start from scratch with the initial data in your database.

Type `./seed_database.sh` into your terminal and you will see all of those commands run. It will look similar, but not identical, to this animation.

![animation showing the seed database script running](./images/seed_database.gif)



