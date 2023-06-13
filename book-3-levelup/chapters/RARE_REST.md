# Build Rare Professionally

In this sprint, you are going to be creating a new API for the Rare client side application to consume.

## Setup
You will be building out the client from scratch! So brush up on your React skills because you're gonna need 'em!

The server side will have the same API requirements from V1, but this time they will be written using the Django REST framework.

Next, choose one team member who will create the API and Client project locally. As a team, walk through the creation of the Django application on that team member's computer. Open the [Level Up API Setup](./DRF_INSTALLS.md) chapter and follow those steps while in your rare-v2 directory. Make sure you do not use `levelup` for the project or application name. Use the following names instead.

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

### Issue Tickets
The requirements for this project are more comprehensive than in V1. You will see many references to admin abilities. An admin is simply a user with more power. How do you give that power to a user? Update a user's `is_staff` property to `True`. Don't say we never gave you anything :)

## Rare ERD from Database Team

https://dbdiagram.io/d/5f885a013a78976d7b77cb74

## Wireframes from Product Team

https://miro.com/app/board/o9J_kiGCSK4=/
