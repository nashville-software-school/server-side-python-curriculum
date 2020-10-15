# Rare Publishing Platform Notes

## Setup

Just in case you haven't updated your computer to use the new default branch name of `main` for git repositories, **EVERYONE** should run this command in your terminal.

```sh
git config --global init.defaultBranch main
```

You are going to need a minimum of two terminal sessions open for this project at all times. Go ahead and open two now.

## Project Directory

1. In the first terminal, every teammate should make a directory on their system for the code for this group project. For example, `~/workspace/python/rare`.
1. `cd` to that directory.
1. Create two sub-directories.
    1. `client`
    1. `server`

## Client Setup

1. In the same terminal session, `cd` to the client directory.
1. `git clone {your repo URL} .` <-- note the single dot at the end.
1. `npm install` to get all required packages installed for the React client.
1. `npm start`

## Server Setup

You are not given any boilerplate code for your server, so **one teammate** should follow these steps and create a new repository in your cohort's organization. Make sure you follow the naming schema of your React client repo.

For example, if your initial repo is named `Rare-Goofy-Gophers`, your new repo should be named `Rare-Server-Goofy-Gophers`.

1. In the second terminal session, `cd` into the `rare/server` directory.
1. `pipenv shell`
1. `pipenv install watchgod autopep8`
1. `touch request_handler.py`
1. `mkdir models posts categories tags comments`
1. `touch models/__init__.py posts/__init__.py categories/__init__.py tags/__init__.py comments/__init__.py`
1. `curl https://www.toptal.com/developers/gitignore/api/python > .gitignore`
1. `echo 'rare.db' >> .gitignore`
1. `echo '.vscode' >> .gitignore`
1. `git init`
1. `git remote add origin {server repo URL}`
1. `git push origin -u main`


# Constraints for Vanilla Python Rare

* No admin. No account type table. Leave off account_type_id on user.
* Since no admins, posts should be automatically published and not wait for approval.
* No image uploads for user profile or post