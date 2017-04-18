# Quick Django Web Application

## Setup

```
mkdir -p ~/workspace/python/exercises/djangomusic && cd $_
```

## Instructions

You are going to build your own Django powered web application. It will be very similar to what we built during the Django tutorial walkthrough.

### Project Setup

1. Create a Django [project](https://docs.djangoproject.com/en/1.11/intro/tutorial01/#creating-a-project) named `music`.
1. Create a [new application](https://docs.djangoproject.com/en/1.11/intro/tutorial01/#creating-the-polls-app) in your project named `history`.
1. In `history/urls.py`, define a route for listing artists, and one for show a specific artist's details.

### Models

1. Build a [model](https://docs.djangoproject.com/en/1.11/intro/tutorial02/#creating-models) representing your `Artist` table.
1. Build a [model](https://docs.djangoproject.com/en/1.11/intro/tutorial02/#creating-models) representing your `Song` table. Ensure that you define the foreign key to the artist table.

### Views

1. Define a [view](https://docs.djangoproject.com/en/1.11/intro/tutorial03/#writing-more-views) to return a [template](https://docs.djangoproject.com/en/1.11/intro/tutorial03/#use-the-template-system) that lists all artists.
1. Define a [view](https://docs.djangoproject.com/en/1.11/intro/tutorial03/#writing-more-views) to return a [template](https://docs.djangoproject.com/en/1.11/intro/tutorial03/#use-the-template-system) that displays the details of a specific artist, and list all of the songs related to that artist.

### Migrations

Remember that every time you create a model, or update it, you need to [create a migration](https://docs.djangoproject.com/en/1.11/intro/tutorial02/#activating-models), and run it.


# Optional Stretch Goals

1. Style your templates with CSS by setting up your application to serve static files.
1. Create a site template for your music history that both the artist list, and the artist detail templates extend.