# Gamer Rater

You have been presented with an unique business opportunity. A local startup has received a round of seed funding to build a platform that lets people talk about, provide information about, and rate the games that they play.

* Players can create unique entries for games. Two players cannot create the same game in the system.
* Players can upload pictures of a game they are playing.
* Players can rate games.
* Players can write a review of a game.
* Games can be searched, sorted by category, and sorted by year of release.
* Players can see the average rating of a game _(by you implementing a custom model property)_.

## Setup

In this project, you are going to create an API, and a React client that will interact with it. This means that you need two new directories in `workspace` and will create two separate Github repositories to track the changes in each.

Start with creating the project for your API. You can use the suggested directory below, or decide on your own.

```sh
cd ~/workspace/python
django-admin startproject raterproject
```

Then create the Github repository for your API project and do an initial commit.

## Step 1: Authentication

You can steal the registration and authentication logic verbatim from Level Up in the `auth.py`.

## The Process

Future chapters will ask you to implement specific features, so use this cheatsheet for the remainder of the project.

1. Initial migration to set up Django authentication tables
1. ERD
1. Models
1. Update database with `makemigrations` and then `migrate`
1. ViewSet
1. Serializer
1. DefaultRouter URL mapping
1. React list component
1. Route setup in application views
1. Repeat steps 3 -> 9 for every resource you want the client to have access to
