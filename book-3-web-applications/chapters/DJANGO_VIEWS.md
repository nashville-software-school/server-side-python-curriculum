# Views and Templates to Display Data

## Creating Sample Data

Before you start creating views so that your can render HTML in the browser, you need some data first. Open up your database and execute the following SQL.

```sql
INSERT INTO libraryapp_library
(title, address)
VALUES
('Bellview Library', '500 Main Street');

INSERT INTO libraryapp_book
(title, isbn, year_published, location_id, author, librarian_id)
VALUES
('Lamb', '59359409490', 2004, 1, 'Christopher Moore', 1);

INSERT INTO libraryapp_book
(title, isbn, year_published, location_id, author, librarian_id)
VALUES
('Taiko', '04275747474873', 2001, 1, 'Eiji Yoshikawa', 1);
```

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

This function is now called a view since it will handle HTTP requests. Which HTTP request, you might ask? Well, you define that in `urls.py`.

Create a `urls.py` file in the `libraryapp` directory. This file will define all of the URLs that your library application will respond to. Place the following code in it.

```py
from django.conf.urls import url
from .views import *


app_name = "libraryapp"
urlpatterns = [
    url(r'^books$', list_books, name='list_books'),
]
```

Then in the `libraryproject/urls.py` file, include the URL mappings from your `libraryapp`. This pattern is followed because Django projects usually grow and start containing more than one application. By having each application define its own URLs, and then importing each set of those into the project, it prevents the project `urls.py` from becoming bloated and hard to read/maintain.

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

Now that you have a view that reads all books from the database, and you configured your application to invoke that view when the `/books` URL is requested, it's time to define your HTML representation with a template.

In the `libraryapp/templates` directory, run the following commands.

```sh
mkdir books
touch books/list.html
```

Then open that file in Visual Studio code, and place the following code into it.

```html
{% load staticfiles %}
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Library</title>
  </head>
  <body>
    <h1>Books</h1>

    <ol>
    {% for book in all_books %}
        <li>
            {{ book.title }}
            by {{book.author}}
            published in {{book.year_published}}
        </li>
    {% endfor %}
    </ol>
  </body>
</html>
```

Look back in your `views/books/list.py` file and review the following two lines at the bottom.

```py
template_name = 'books/list.html'
return render(request, template_name, {'all_books': all_books})
```

When a view wants to generate some HTML representations of data, it needs to specify a template to use. Above, the `template_name` variable is holding the path and filename of the template you just created.

Then the `render()` method is invoked. That method takes the HTTP request as the first argument, the template to be used as the second argument, and then a dictionary containing the data to be used in the template.

In this case, the dictionary has a single property labeled `all_books` and its value is the list of book objects that the view generates.

The key name is able to be used in the template, which is why the template has the following loop.

```py
{% for book in all_books %}
    ...
{% endfor %}
```

If you changed your view to the following code.

```py
return render(request, template_name, {'the_list_of_books': all_books})
```

Then your template loop would also change to the following.

```py
{% for book in the_list_of_books %}
    ...
{% endfor %}
```

Yep, this is Python code written inside an HTML file. Weird, I know. It's like that [cheesy, old Reese's Peanut Butter Cup commercial](https://www.youtube.com/watch?v=O7oD_oX-Gio).

"Hey! You got Python in my HTML"

"Hey! You got HTML on my Python"

**Template language rule #1:** When you want to write logical code in a Django template like for loops, or if statements, you need to wrap the code in `{%  %}`.

**Template language rule #2:** When you want to display the value of variables, you wrap the variable name in `{{  }}`.

Here's another example that shows both the for loop, but with an nested if statement to show you the use of the interpolation punctuation.

```html
{% for book in all_books %}
    {% if book.year_published > 2000 %}
        <li>{{ book.title }} by {{book.author}} published in {{book.year_published}}</li>
    {% endif %}
{% endfor %}
```

## Create a User with the Administration Site

Visit http://localhost:8000/admin and add another user to your system. You pick the username and password.

![adding a user via the admin site](./images/add-user-admin-site.gif)

Once you have a new user, add a book to your database, and assign your new user as the librarian that added it to the inventory.

```sql
INSERT INTO libraryapp_book
(title, isbn, year_published, location_id, author, librarian_id)
VALUES
('The Golem and the Jinni', '8592475822', 2013, 1, 'Helene Wecker', 2);
```

> **Lightning Exercise:** Create two more users with the admin site, and then use SQL to create a book that each librarian added to the inventory.

## Library View

Now it's your turn to create a view, and a corresponding template to list libraries.

1. Create `libraryapp/views/libraries/list.py`
1. Create `libraryapp/templates/libraries/list.html`
1. Define the URL that you want to expose to list libraries in `libraryapp/urls.py`

## Advanced Creation of Simple Model Instances

> **Warning:** The following code requires a solid understanding of the concept of higher order functions. If the code you have written so far makes sense to you, and the code below does not after reading it and reflecting upon it, then it is in your best interest to move on to the next concept.

Create a `libraryapp/models/modelfactory.py` file and place the following code in it.

```py
import sqlite3

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
```

Add the function to the models package in `libraryapp/models/__init__.py`.

```py
from .library import Library
from .book import Book
from .librarian import Librarian
from .modelfactory import model_factory
```

Import the factory function into the book list module, and invoke the function with the Book model as an argument. Then when you invoke `fetchall()`, then end result will be a list of **`Book`** instances.

> **Rule for using model_factory:** Your SQL statement must query a single table, and each column in the table must be specified in the SQL.

```py
import sqlite3
from django.shortcuts import render
from libraryapp.models import Book
from libraryapp.models import model_factory
from ..connection import Connection


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

        all_books = db_cursor.fetchall()

    template_name = 'books/list.html'
    return render(request, template_name, {'all_books': all_books})
```