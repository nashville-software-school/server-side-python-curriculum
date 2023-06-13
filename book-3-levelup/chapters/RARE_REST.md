# Build Rare Professionally

During this sprint, your task is to create a new API for the Rare client-side application to consume.

## Setup
You will start building the client application from scratch! So make sure you refresh your React skills because you'll need them!

The server-side will have the same API requirements as in V1, but this time they will be implemented using the Django REST framework.

Next, designate one team member to create the API and Client projects locally. As a team, go through the process of setting up the Django application on that team member's computer. Open the [Level Up API Setup](./DRF_INSTALLS.md) section and follow the instructions while in your rare-v2 directory. Ensure that you do not use `levelup` as the project or application name. Instead, use the following names.

### Creating the Project

```sh
django-admin startproject rare
```

### Creating the API Application

```sh
python3 manage.py startapp rareapi
```

### Creating the .gitignore

Once the project is set up, be sure to create a `.gitignore` file and paste the contents from [this URL](https://www.toptal.com/developers/gitignore/api/django) into it before making your first commit. Finally, initialize a local git repository with `git init` and connect it to your team's server-side GitHub repository using `git remote add origin <github ssh url>`. Once you have everything set up, push the code. The other team members can now clone the new Django project repository.

### Issue Tickets
The requirements for this project are more extensive compared to V1. You will come across various mentions of administrative capabilities. An admin user simply possesses more privileges. How can you grant such power to a user? Update a user's `is_staff` property to `True`. Remember, we're always here to support you :)

## Rare ERD from the Database Team

https://dbdiagram.io/d/5f885a013a78976d7b77cb74

## Wireframes from the Product Team

https://miro.com/app/board/o9J_kiGCSK4=/
