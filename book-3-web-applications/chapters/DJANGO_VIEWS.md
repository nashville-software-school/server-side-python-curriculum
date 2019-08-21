# Views and Templates to Display Data

## Django Views

The main responsiblity of a Django view is to respond to a HTTP request on a certain URL. The view will hold all of the logic required to get the appropriate data from the database, and then attach that data to a template for representing it in HTML.

Time to write your first view. Be in your `libraryapp` directory and run the following commands to start setting it up.

```sh
mkdir views && cd $_
touch __init__.py connection.py
mkdir books && cd $_
touch list.py
```

Open `views/connection.py` and place the following code in it. This allows any view to import the path to the database so each can connect to it and query data.

```py
class Connection:
    db_path = "/absolute/path/to/library-management/libraryproject/db.sqlite3"
```

Next, open `views/books/list.py` and paste in the following code. Note that the row factory being used for this connection to the database uses the built-in `sqlite3.Row` method. This allows developers to access columns in each row in the dataset by the column name instead of by index in the tuple.

```py
import sqlite3
from django.shortcuts import render
from libraryapp.models import Book
from ..connection import Connection


def list_books(request):
    with sqlite3.connect(Connection.db_path) as conn:
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()

        db_cursor.execute("""
        select
            b.id,
            b.title,
            b.isbn,
            b.author,
            b.year_published,
            b.librarian_id,
            b.location_id
        from libraryapp_book b
        """)

        all_books = []
        dataset = db_cursor.fetchall()

        for row in dataset:
            book = Book()
            book.id = row['id']
            book.title = row['title']
            book.isbn = row['isbn']
            book.author = row['author']
            book.year_published = row['year_published']
            book.librarian_id = row['librarian_id']
            book.location_id = row['location_id']

            all_books.append(book)

    template_name = 'books/list.html'
    return render(request, template_name, {'all_books': all_books})
```

This function is now called a view since it will handle HTTP requests. Which HTTP request, you might ask? Well, you define that in `urls.py`. Open `libraryproject/urls.py` and replace the code that is in there with the following code.

Create `urls.py` file in the `libraryapp` directory. This file will define all of the URL that you library application will respond to. Place the following code in it.

```py
from django.conf.urls import url
from .views import *


app_name = "libraryapp"
urlpatterns = [
    url(r'^books$', list_books, name='list_products'),
]
```

```py
from django.contrib import admin
from django.conf.urls import include, url
from django.urls import path
from libraryapp.models import *

urlpatterns = [
    path('admin/', admin.site.urls),
    url(r'^', include('libraryapp.urls')),
]
```



## Django HTML Templates



## Advanced Creation of Simple Model Instances

> **Important:** The following code requires a solid understanding of Python list comprehensions, and the concept of higher order functions. If the code you have written so far makes sense to you, and the code below does not after reading it and reflecting upon it, then it is in your best interest to move on to the next concept.

```py
import sqlite3
from django.shortcuts import render
from libraryapp.models import Book
from ..connection import Connection

# Higher order function to create instances of models
# when performing single table queries
def model_factory(model_type):
    def create(cursor, row):
        instance = model_type()
        smart_row = sqlite3.Row(cursor, row)
        for col in smart_row.keys():
            setattr(instance, col, smart_row[col])
        return instance
    return create

def list_books(request):
    with sqlite3.connect(Connection.db_path) as conn:
        conn.row_factory = model_factory(Book)
        db_cursor = conn.cursor()

        db_cursor.execute("""
        select
            b.id,
            b.title,
            b.isbn,
            b.author,
            b.year_published,
            b.librarian_id,
            b.location_id
        from libraryapp_book b
        """)

        all_books = [book for book in db_cursor.fetchall()]

    template_name = 'books/list.html'
    return render(request, template_name, {'all_books': all_books})
```