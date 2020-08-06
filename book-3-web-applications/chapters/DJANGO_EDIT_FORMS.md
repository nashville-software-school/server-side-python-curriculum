# Editing Resources

It's time to revisit editing resources - everyone's favorite part of NSS. ❤️

Here's the process, which is slightly different that doing it in a single page application like you did in the client-side course.

## Process for Editing a Resource

1. Place an edit button on the detail view of the resource by modifying the template. The button should be in a form along with a hidden input field specifying the action.
1. Code in the view will check for the hidden input field of `actual_method` and see if its value is "EDIT".
1. The view will then query the database for the single record to be edited.
1. The server will return a template, with the single resource object in its context.
1. The template will populate the `value` attribute of all of the input fields with their corresponding value from the context's resource object.
1. Once the user has changed the values, and clicks the Update button, the form will be submitted to the detail view for the resource.
1. The view will then check for the `actual_method` field again, and see if its value is "PUT".
1. Then the view will perform an UPDATE statement in the database, and then redirect the user back to the detail view.

This is a difficult signal flow to visualize, and takes months _(sometimes years)_ of practice before it feels comfortable. You won't get it right the first, second, third, or fourth time you try it. Maybe on the 15th time.

Let's start.

### The Edit Button

The Edit button requires some thought first. When the user clicks that button, what is actually being requested? The book is not actually being modified at that moment, but rather the user is requesting that s/he be provided with an interface to change the book's state. You will provide an HTML form - just like the create form - but when the form is rendered, the book's details should be pre-populated.

Therefore, this is a GET request, not a PUT or a POST. Normally, the affordance for a GET request is a hyperlink. In this case, though, you would want to provide a button next to the delete button so that the UX is consistent.

Luckily, HTML form elements also support the verb of GET. Even though, the vast majority of the time, you will use POST with a form, in this case, a GET is more appropriate.

Refactor your book detail template to the following code.

```jinja
{% load static %}
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Library</title>
</head>

<body>

    <section id="book-details">
        <h1>{{ book.title }}</h1>
        <h2>By {{ book.author }}</h2>

        <div>Published in {{ book.year_published }}</div>
        <div>ISBN: {{ book.isbn }}</div>
    </section>

    <section id="book-actions" style="display:flex;">
        <form action="{% url 'libraryapp:book' book.id %}" method="POST">
            {% csrf_token %}
            <input type="hidden" name="actual_method" value="DELETE">
            <button>Delete</button>
        </form>

        <form action="{% url 'libraryapp:book_edit_form' book.id %}" method="GET">
            {% csrf_token %}
            <button>Edit</button>
        </form>
    </section>

</body>

</html>
```

This produces the following HTML for the Edit button.

```html
<form action="/books/21/form" method="GET">
    <input type="hidden" name="csrfmiddlewaretoken" value="...">
    <button>Edit</button>
</form>
```

This is a new URL pattern, so you need to add the following pattern to your `urls.py`.

> #### libraryproject/libraryapp/urls.py

```py
path('books/<int:book_id>/form/', book_edit_form, name='book_edit_form'),
```

### Book Edit Form View

Now you need a view to handle that GET request and send the HTML form back to the client. Add the following view function to the `form.py` module.

> #### libraryproject/libraryapp/views/books/form.py

```py
@login_required
def book_edit_form(request, book_id):

    if request.method == 'GET':
        book = get_book(book_id)
        libraries = get_libraries()

        template = 'books/form.html'
        context = {
            'book': book,
            'all_libraries': libraries
        }

        return render(request, template, context)
```

### Update the Package

Since you have a new view, you need to import it into the package.

> #### libraryproject/libraryapp/views/\_\_init__.py

```py
from .books.form import book_form, book_edit_form
```

### Create and Edit Form

Since you are now sending the `form.html` template to the client in two different cases...

* When a book is being created
* When a book is being edited

...you need to modify the template. Replace your template with the code below. In this version, note that the `value` attribute of each of the input fields interpolates the corresponding property on a Book object.

In the dropdown, there is an inline `{% if %}` statement that pre-selects the library that the book is assigned to.

Then at the end, a hidden input field is added **only** when the form is being used for edit. This hidden input field will store the `id` property of the book, and will be used by the view when posted.

Notice that there are two `{% if %}` conditions now in the template.

The first one determines where the form should be submitted.

1. If the `book.id` parameter exists in the context, that means that the user is changing the current state of the book. Therefore, the POST request should be sent to `/books/{id}`.
1. Otherwise, the user is creating a new book, and the POST request should be sent to `/books`.

The second one determines which button should appear, and adds an additional hidden field if the user is editing. This additional field with differentiate between the two, otherwise, identical POST requests. On creation, it's a straightforward POST operation. When editing, the request sent to the server still must be POST - _since HTML forms don't support PUT_ - so you are passing along additional information that you can check for when processing the form.

> #### libraryproject/libraryapp/templates/books/form.html

```jinja
{% load static %}
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Library</title>
</head>

<body>
    <h1>Inventory Book</h1>

    {% if book.id is not None %}
        <form action="{% url 'libraryapp:book' book.id %}" method="post">
    {% else %}
        <form action="{% url 'libraryapp:books' %}" method="post">
    {% endif %}
        {% csrf_token %}
        <fieldset>
            <label for="title">Title: </label>
            <input id="title" type="text" name="title" value="{{ book.title }}">
        </fieldset>
        <fieldset>
            <label for="author">Author: </label>
            <input id="author" type="text" name="author" value="{{ book.author }}">
        </fieldset>
        <fieldset>
            <label for="year_published">Year of publication: </label>
            <input id="year_published" type="number" name="year_published" value="{{ book.year_published }}">
        </fieldset>
        <fieldset>
            <label for="isbn">ISBN: </label>
            <input id="isbn" type="text" name="isbn" value="{{ book.isbn }}">
        </fieldset>
        <fieldset>
            <label for="location">Library: </label>
            <select id="location" type="text" name="location">
                {% for library in all_libraries %}
                <option {% if library.id == book.location_id %}selected{% endif %} value="{{ library.id }}">
                    {{ library.title }}</option>
                {% endfor %}
            </select>
        </fieldset>

        {% if book.id is not None %}
            <input type="hidden" name="actual_method" value="PUT">
            <input type="submit" value="Update" />
        {% else %}
            <input type="submit" value="Create" />
        {% endif %}

    </form>
</body>

</html>
```

Python is very forgiving. If the `book` object is not in the context dictionary for the template, then the form fields will not be populated with a value, even though the code explicitly accesses a property on an object that does not exist. You might expect an exception to be thrown, but it does not.

## Updating Database from User Input

Now that you are displaying an edit form to your user, the next step is to update the database record once the new values have been entered by the user and the Update button is clicked. The form will do a POST request, but also pass along a hidden key of `actual_method` with a value of `PUT`.

```html
<form action="/books/21" method="post">
    <input type="hidden" name="csrfmiddlewaretoken" value="...">

    <!-- Other inputs left out for brevity's sake -->

    <input type="hidden" name="actual_method" value="PUT">
    <input type="submit" value="Update">
</form>
```

That allows you to check for that value in the POST logic of your `book_details()` method. In that case, you will have a SQL `UPDATE` statement to change the values of the record in the database.

> #### libraryproject/libraryapp/views/books/details.py

```py
@login_required
def book_details(request, book_id):
    if request.method == 'GET':
        book = get_book(book_id)
        template_name = 'books/detail.html'
        return render(request, template_name, {'book': book})

    elif request.method == 'POST':
        form_data = request.POST

        # Check if this POST is for editing a book
        if (
            "actual_method" in form_data
            and form_data["actual_method"] == "PUT"
        ):
            with sqlite3.connect(Connection.db_path) as conn:
                db_cursor = conn.cursor()

                db_cursor.execute("""
                UPDATE libraryapp_book
                SET title = ?,
                    author = ?,
                    isbn = ?,
                    year_published = ?,
                    location_id = ?
                WHERE id = ?
                """,
                (
                    form_data['title'], form_data['author'],
                    form_data['isbn'], form_data['year_published'],
                    form_data["location"], book_id,
                ))

            return redirect(reverse('libraryapp:books'))

        # Check if this POST is for deleting a book
        if (
            "actual_method" in form_data
            and form_data["actual_method"] == "DELETE"
        ):
            with sqlite3.connect(Connection.db_path) as conn:
                db_cursor = conn.cursor()

                db_cursor.execute("""
                    DELETE FROM libraryapp_book
                    WHERE id = ?
                """, (book_id,))

            return redirect(reverse('libraryapp:books'))

```

## Demo

Time to try it out. If everything is in place you should be able to edit any of your books.

![animation of editing book](./images/edit-in-action.gif)
