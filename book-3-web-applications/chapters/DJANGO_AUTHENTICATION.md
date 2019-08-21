# Added Authentication to your Django Application

## Setting up the Routes

Open `libraryapp/urls.py` and update your import statement to import the include method from the `django.conf.urls` package.

```py
from django.conf.urls import url, include
```


Then add the URLs to your existing patterns. This lets your application use the built-in login and logout views that Django provides.

```py
url(r'accounts/', include('django.contrib.auth.urls')),
```

You never need to touch these views, and they live in Django and have all the logic you need.

### Login Screen Template

By default, the login view looks for a template path of  `registration/login.html`, so you need to create the `libraryapp/templates/registration/login.html` file. Then place the following code in it.

```py
<h2>Login</h2>
<form method="post">
    {% csrf_token %}
    {{ form.as_p }}
    <button type="submit">Login</button>
</form>
```

## Where to Go When User Authenticates

Open your `settings.py` file and place the following configuration variable at the bottom of the file. This tells Django which URL it should redirect the browser to when the user authenticates. For now, you will redirect the user to the list of books.

```py
LOGIN_REDIRECT_URL = '/books'
```

## Logging In

Now go to the http://localhost:8000/accounts/login URL and you should see the simple login form. Go ahead and authenticate with the superuser account that you created.

![animation of user authenticating](./images/logging-in.gif)

## Requiring Authentication for Views

As you app stands right now, you can login, view books, view libraries, and view librarians. However, login doesn't really do anything since a user can still view all information even if s/he doesn't authenticate. Time to change that.

You are going to modify your application so that books, libraries, and librarians can only be viewed if the user is authenticated.

Django provide a useful decorator named `@login_required`. First, import the decorator.

```py
from django.contrib.auth.decorators import login_required
```

Then put that decorator above your book list view.

```py
@login_required
def list_books(request):
```

Make sure you visit http://localhost:8000/accounts/logout to ensure that you are unauthenticated. Then go to the book list, and you will be immediately redirected to the login view.

![animation of visiting the book list and being redirected to login view](./images/login-required-implementation.gif)