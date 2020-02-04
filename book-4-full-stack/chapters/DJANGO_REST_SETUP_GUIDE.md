### The Django REST tutorial is thorough, but walks you through a lot of steps that they end up having you refactor. It can get confusing quickly. So, here is Joe's streamlined guide to getting a basic DRF API running. No deep explanations or definitions here, just a step-by-step list. Don't use anything that you don't understand well enough. Read the docs for unfamiliar terms.

#### If you think we've skipped anything important, or listed something out of order, let us know with a PR. We will update this to make it better/clearer for you and future generations of students who will sing your praises.

#### Helpful hint: You will type python manage.py  a lot. Consider making an alias in your .zshrc file. Mine is "pyman"

1. Create a project folder and cd into it
2. Create a virutal env and run it ( run pip install virtualenv if you don't have it installed yet )
    1. > `virtualenv env` ('env' is the virtual environment's name. You can call it anything you like)
    2. > `source env/bin/activate`
    **Non-Linux Windows users: cd into the env directory and run ```. Scripts/activate```.**
    3. > `pip install django djangorestframework`
4. Create your new project:
    > `django-admin startproject foo`
5. cd into foo/
6. Create an app for your project:
    > `python manage.py startapp bar`
7. Add new app and rest_framework to project's INSTALLED_APPS setting in foo/settings.py by its name:
```python
  INSTALLED_APPS = [ 'bar', 'rest_framework', …etc ]
  ```
8. Add model[s] to bar/models.py
    1. Tutorial link: http://www.django-rest-framework.org/tutorial/1-serialization/#creating-a-model-to-work-with
9. Create initial migrations:
    > `python manage.py makemigrations bar` ( bar is name of app )
10. Run migration file(s) to create table(s) in db:
    > `python manage.py migrate`
11. Create serializer file for your app and add serialize[s] for your model[s] (NOTE: Tutorial starts you out with regular serializers, then farther down the page has you refactor to use ModelSerializers. Might just want to start there)
    1. Tutorial link: http://www.django-rest-framework.org/tutorial/1-serialization/#creating-a-serializer-class
    2. > `touch bar/serializers.py`
    3. Import:
        1. serializers from rest_framework
        2. your model[s] from bar.models
        3. User from django.contrib.auth.models ( if using authentication )
    4. Use hyperlinked model serializers to create URLs as values for related entities ( like Users and profiles, Blog posts and comments, etc ). For models with no relations, use serializers.ModelSerializer:
        ```python
        class BarModelSerializer(serializers.HyperlinkedModelSerializer):
        ```
        2. Tutorial link: http://www.django-rest-framework.org/tutorial/5-relationships-and-hyperlinked-apis/#hyperlinking-our-api
    5. Use the Meta class to define props to associate with the model that _won't be part of the db_. Great way to display related properties of a model, i.e. a User's blog posts or favorite movies, or to filter / format the data some way during the (de)serialization process
12. Create views for how to send the data back to the client ( Tutorial jumps you through multiple hoops to get to final view versions, so I suggest skipping straight to the last step, using ViewSets )
    1. Tutorial Link: http://www.django-rest-framework.org/tutorial/6-viewsets-and-routers/#tutorial-6-viewsets-routers
    2. Django gives you roughly 3 million ways to approach this. We will use viewsets, which automate pretty much all the things
    3. Import:
        1. your model[s] from bar.models
        2. your serializer classes from bar.serializers
        3. viewsets from rest_framework
    4. Create classes for each model's set of views:
        ```python
        class myBarModelViewSet(viewsets.ModelViewSet):
        ```
    5. If the view will include an ability to save instances of the model, and the model has a user association to save with it, you can overwrite the built-in save method with:
        ```python
        def perform_create( self, serializer):

          serializer.save(relatedBarUser=self.request.user)
        ```

13. Create a Router class in a new file, bar/urls.py, to work hand-in-hand with the viewsets views. In bar/urls.py
    1. Tutorial Link: http://www.django-rest-framework.org/tutorial/6-viewsets-and-routers/#using-routers
    2. Import
        1. DefaultRouter from rest_framework.routers
        2. views from bar
        3. url and include from django.conf.urls
    3. instantiate a Router
        1. router = DefaultRouter()
    4. Register your viewset views with the router
        1. router.register(r'bar', views.MyBarViewSet)
        2. router.register(r'users', views.UserViewSet)
    5. Then in the url_patterns list, you only have to include one line (?)
        1. path('', include(router.urls))
    6. Finally, add the bar/urls.py to the root project urls.py file
14. Create an endpoint for the root of the API, which is basically a table of contents
    1. Tutorial link: http://www.django-rest-framework.org/tutorial/5-relationships-and-hyperlinked-apis/#creating-an-endpoint-for-the-root-of-our-api
15. Fire up your dev server with
    > python manage.py runserver

16. Navigate to `/myBarModel` to see if the Django UI presents you with a lovely page where you can add new instances of your model to the db.
17. Another way to add new instances of your models and/or your users to the db is by creating a superuser and leveraging the Django admin UI ( which you can get to by loading /admin in the browser, for example : `localhost:8000/admin` )
    1. > python manage.py createsuperuser
    2. enter a username
    3. enter an email
    4. enter a password
    5. start your server
        > python manage.py runserver and navigate to the url + /admin  and login
    6. To add instances of a model from your app, edit bar/admin.py
        1. Import:
            1. admin from django.contrib
            1. MyBarModel from .models
        1. Add this line of code:   `admin.site.register(MyBarModel)`
18. Once you have some data saved, you can also view your collection by adding .json to the end of the URL, which will show you the data in JSON form, minus the Django UI
