# Hyperlinks to Individual Resources

In this chapter, you are going to make hyperlinks out of the items in your list templates, write views to query a single resource from the database, and have new patterns for URLs with a route parameter at the end. For example...

http://localhost:8000/books/1

The `1` is the route parameter.

## URL Pattern

Start by adding the following URL patters to `urls.py`.

```py
url(r'^books/(?P<book_id>[0-9]+)/$', book_details, name="book_details"),
```

The `(?P<book_id>[0-9]+)` part of that URL pattern is a regular expression, mixed with some Django magic, to capture any integer that is the route parameter, and stores that number in the `book_id` variable.

## Detail View

In the view, query for a single book in the database and use the `fetchone()` method instead of the `fetchall()` that you use in the list view. Also note that the `book_id` variable that you specified in the URLs pattern above gets automatically sent as an argument to the `book_details` view.

That's pretty cool.

Create the `views/books/details.py` file and use the following code.

```py
import sqlite3
from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from libraryapp.models import Book
from libraryapp.models import model_factory
from ..connection import Connection


@login_required
def book_details(request, book_id):
    with sqlite3.connect(Connection.db_path) as conn:
        conn.row_factory = model_factory(Book)
        db_cursor = conn.cursor()

        db_cursor.execute("""
        SELECT
            b.id,
            b.title,
            b.isbn,
            b.author,
            b.year_published,
            b.librarian_id,
            b.location_id
        FROM libraryapp_book b
        WHERE b.id = ?
        """, (book_id))

        book = db_cursor.fetchone()

    template_name = 'books/detail.html'
    return render(request, template_name, {'book': book})
```


## Add View to Package

Add the new view to `__init__.py`

```py
from .books.details import book_details
```

## Detail Template

Create `templates/books/detail.html` and use the following code.

```html
{% load staticfiles %}
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Library</title>
  </head>
  <body>
    <h1>{{ book.title }}</h1>
    <h2>By {{ book.author }}</h2>

    <div>Published in {{ book.year_published }}</div>
    <div>ISBN: {{ book.isbn }}</div>
  </body>
</html>
```

## Refactor List Template

Make each item a hyperlink. Use `reverse()` and interpolate the book `id` in each URL.