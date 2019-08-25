# Getting and Posting Forms

> **Instructor Note:** Review HTTP verbs and CRUD operations with students before this lesson. Also review using the Chrome Dev Tools network tab to inspect requests.

## Librarians Adding Books in Libraries

Time for you to implement your first form so that users can enter in a new book and assign it to a library. For now, you can start with building the template. Create the `templates/books/form.html` template, and put the following code in it.

```html
{% load staticfiles %}
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Bangazon</title>
  </head>
  <body>
    <h1>Inventory Book</h1>


    <form action="{% url 'libraryapp:create_book' %}" method="post">
      {% csrf_token %}
      <fieldset>
          <label for="title">Title: </label>
          <input id="title" type="text" name="title">
      </fieldset>
      <fieldset>
          <label for="author">Author: </label>
          <input id="author" type="text" name="author">
      </fieldset>
      <fieldset>
          <label for="year_published">Year of publication: </label>
          <input id="year_published" type="number" name="year_published">
      </fieldset>
      <fieldset>
          <label for="isbn">ISBN: </label>
          <input id="isbn" type="text" name="isbn">
      </fieldset>
      <fieldset>
          <label for="location">Library: </label>
          <select id="location" type="text" name="location">
                {% for library in all_libraries %}
                    <option value="{{ library.id }}">{{ library.title }}</option>
                {% endfor %}
          </select>
      </fieldset>

      <input type="submit" value="Add It" />
    </form>
  </body>
</html>
```

## URL Endpoint for Creating Books

Create the following entry in your URL patterns for handling the creation of a single book. Both the GET and the POST requests will be sent to this URL.

```py
url(r'^book$', create_book, name='create_book'),
```

## Handling GET and POST Requests

When the user visits the URL http://localhost:8000/book _(notice this is singular)_ the browser performs a GET request to that URL. In that specific case, your Django app will send the form to the user to fill out.

Create the `views/books/create.py` module and place the following code in it.

```py
import sqlite3
from django.urls import reverse
from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from libraryapp.models import Book, Library, model_factory
from ..connection import Connection


@login_required
def create_book(request):

    if request.method == 'GET':
        '''
        Check if the request method is a GET, and if so, get all the
        libraries in the system so that the book form has a <select>
        element with all the libraries as <option> elements
        '''

        with sqlite3.connect(Connection.db_path) as conn:
            conn.row_factory = sqlite3.Row
            db_cursor = conn.cursor()

            db_cursor.execute("""
            SELECT
                l.id,
                l.title,
                l.address
            FROM libraryapp_library l
            """)

            dataset = db_cursor.fetchall()
            all_libraries = []

            for row in dataset:
                library = Library()
                library.title = row['title']
                library.address = row['address']

                all_libraries.append(library)

        template_name = 'books/form.html'
        return render(request, template_name, {'all_libraries': all_libraries})

```

## Handling the POST Request

When the user fills out the form and clicks the submit button, the browser will collect all the values of the form and submit a POST request back to the same URL. You must then handle that request and create a book.

Place the following code in your file at the bottom to handle the case of the request method being POST.

```py
    elif request.method == 'POST':
        '''
        Check if the request method is a POST, which means the user
        filled out the form and clicked the submit button. Then extract
        all the form fields from the request, and assign those values
        to a new Book instance. Then invoke the `.save()` method to
        insert the data into the database.
        '''

        form_data = request.POST

        with sqlite3.connect(Connection.db_path) as conn:
            db_cursor = conn.cursor()

            db_cursor.execute("""
            INSERT INTO libraryapp_book
            (
                title, author, isbn,
                year_published, location_id, librarian_id
            )
            VALUES (?, ?, ?, ?, ?, ?)
            """,
            (form_data['title'], form_data['author'],
                form_data['isbn'], form_data['year_published'],
                request.user.librarian.id, form_data["location"]))

        return redirect(reverse('libraryapp:books'))
```

## Creating Libraries

Now it is your turn to follow this pattern to create a form for creating a new entry in the database for libraries. You need to create the following items to make it work.

1. A Django template in `templates/libraries/form.html` that displays a form for entering in all the values for a library.
1. A new URL pattern in `libraryapp/urls.py`
1. A new view in `views/libraries/create.py` to handle the GET and POST requests.