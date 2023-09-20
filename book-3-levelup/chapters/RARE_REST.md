# Build Rare Professionally

In this sprint, you are going to be creating a new API for the Rare client side application to consume.

## Setup
Accept the assignments as usual. One member follows the assignment links and creates the group name in each. The other members follow the links and join the created teams. 

The new client repo will have a React app in it that _some_ of you will recognize. It is pretty much complete, but you will need to spend some time reading the code to familarize yourself with how it. We recommend creating a rare-v2 directory locally to clone this repo into, so you can keep your client and server projects in one place in your file system.

The server side repo is a blank slate, ready for your elegant and advanced implementation of the API requirements from V1, but this time written using the Django REST framework.

Next, choose one team member who will create the API project locally. As a team, walk through the creation of the Django application on that team member's computer. Open the [Level Up API Setup](./DRF_INSTALLS.md) chapter and follow those steps while in your rare-v2 directory. Make sure you do not use `levelup` for the project or application name. Use the following names instead.

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

Add the following pattern to the bottom of your gitignore file.

```txt
migrations/**
```

### Issue Tickets
The requirements for this project are more comprehensive than in V1. You will see many references to admin abilities. An admin is simply a user with more power. How do you give that power to a user? Update a user's `is_staff` property to `True`. Don't say we never gave you anything :)

## Rare ERD from Database Team

https://dbdiagram.io/d/5f885a013a78976d7b77cb74

## Wireframes from Product Team

https://miro.com/app/board/o9J_kiGCSK4=/

## Checklist

Use this checklist to ensure that you have everything set up correctly before you make your first commit and PR.

- [ ] Django project created
- [ ] API application created
- [ ] Deleted `models.py` and `views.py`
- [ ] Created `.gitignore`
- [ ] Added `migrations/**` to gitignore
- [ ] `.pylint` file created
- [ ] `.vscode/settings.json` file created with proper config settings
- [ ] `settings.py` updated with correct installed apps, CORS config, authentication/permission config, and middleware config


