# Build Rare Professionally

In this sprint, you are going to be creating a new API for the Rare client side application to consume.

## Rare ERD from Database Team

https://dbdiagram.io/d/5f885a013a78976d7b77cb74

## Wireframes from Product Team

https://miro.com/app/board/o9J_kiGCSK4=/


## Sprint Process

**Step 1:** Read every ticket and give it a weight. Use the ERD and wireframes above as resources.

**Step 2:** Come to a team commitment for how many tickets you will complete in the sprint and communicate it to your Scrum Master _(an instructor)_.

**Step 3:** Each teammate will pull a ticket into the doing column and assign him/herself to it.

**Step 4:** Create branches and begin work. Create draft PRs ASAP and commit often.

## Setup

Accept the assignments as usual. One member follows the assignment links and creates the group name in each. The other members follow the links and join the created teams.

The client repo will have some boilerplate code in it to get you started.

The server side repo is a blank slate, ready for your elegant and advanced implementation of the API requirements written using the Django REST framework.

Next, choose one team member who will create the API project locally. As a team, walk through the creation of the Django application on that team member's computer. Open the [Level Up API Setup](./DRF_INSTALLS.md) chapter and follow those steps while in your rare directory. Make sure you do not use `levelup` for the project or application name. Use the following names instead.

### Creating the Project

```sh
django-admin startproject rare
```

### Creating the API Application

```sh
python3 manage.py startapp rareapi
```

### Creating the .gitignore

Once the project is set up, make sure you create a `.gitignore` file and put the content at [this URL](https://www.toptal.com/developers/gitignore/api/django) in there before your first commit. Finally, create a local git repo with `git init` and connect it to your team's server side github repo with `git remote add origin <github ssh url>`. Once you have everything setup, push up the code. The other team members can now clone down the new Django project repo.

### Ignoring migrations

Add the following pattern to the bottom of your .gitignore file.

```txt
rareapi/migrations/**
```

### Issue Tickets

The requirements for this project are quite comprehensive. You will see many references to admin abilities. An admin is simply a user with more power. How do you give that power to a user? Update a user's `is_staff` property to `True`. Don't say we never gave you anything :)

## Setup Checklist

Use this checklist to ensure that you have everything set up correctly before you make your first commit and PR.

- [ ] Django project created
- [ ] API application created
- [ ] Deleted `models.py` and `views.py`
- [ ] Created `.gitignore`
- [ ] Added `rareapi/migrations/**` to gitignore
- [ ] `.pylint` file created
- [ ] `.vscode/settings.json` file created with proper config settings
- [ ] `settings.py` updated with correct installed apps, CORS config, authentication/permission config, and middleware config

## Fixtures You Can Use

When you are ready to start making fixtures for your project, here are some tokens and users you can start with.

Each user's password is their last name.

Note that the `users.json` file only populates the Django user table. You will have to create a `rare_users.json` file to make a corresponding row in the **RareUser** table.

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


## Database Seeding Bash Script

1. In the top-level directory of your project, create a file named `seed_database.sh`.
2. Copy pasta the following content into it.
   ```sh
   #!/bin/bash

   rm db.sqlite3
   rm -rf ./repairsapi/migrations
   python3 manage.py migrate
   python3 manage.py makemigrations repairsapi
   python3 manage.py migrate repairsapi
   python3 manage.py loaddata users
   python3 manage.py loaddata tokens

   # Add more `loaddata` commands for each of your other fixtures
   ```
3. Run the following command in your terminal. It makes the file an [executable script](https://linuxhandbook.com/make-file-executable/).
    ```sh
    chmod u+x ./seed_database.sh
    ```

## Seed Your Database

Now, anytime you make a change to one of the models in the initial phase of development, you can run the following command to rebuild the database and populate it with the fixtures data.

```sh
./seed_database.sh
```