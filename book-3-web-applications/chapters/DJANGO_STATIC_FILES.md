# Static Files in Django

In the previous chapter about extending base templates, you put a `<style>` tag in the `base.html` template. This is certainly not best practice. You want to have all of your styles in `.css` files contained in a `styles` subdirectory.

When you start a Django application, one of the directories that it creates for you is `static`. Go ahead and create a sub-directory of `styles` in that directory, and then create a `styles/base.css` file. Remove the styles from the base HTML file and place the following CSS in the new static file.

> #### `libraryapp/static/styles/base.css`

```css
body {
    margin: 0;
    padding: 0;
    font-size: 1.5em;
    font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
}

.main-content {
    padding: 1em 2em;
}

.navList {
    list-style-type: none;
    display: flex;
    border: 1px solid lightgray;
    padding: 1em;
    margin: 0;
}

.navList__route {
    margin: 0 0.5em;
}
```

## CSS Content Block

Update your base template to include the base CSS and add a content block so that dervied templates can specify their own CSS files. Note the keyword of `static` in the interpolated value of the `href` attribute of the `<link>` tag. It also adds a `<main>` element around your content block.

> #### `libraryapp/templates/shared/base.html`

```jinja
{% load staticfiles %}
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Library</title>

    <link rel="stylesheet" href="{% static 'styles/base.css' %}" />

    {% block css %}
    {% endblock %}
</head>

<body>

    <nav id="site-nav">
        <ol class="navList">
            <li class="navList__route"><a href="{% url 'libraryapp:home' %}">Home</a></li>
            <li class="navList__route"><a href="{% url 'libraryapp:libraries' %}">Libraries</a></li>
            <li class="navList__route"><a href="{% url 'libraryapp:books' %}">Books</a></li>
            <li class="navList__route"><a href="{% url 'libraryapp:librarians' %}">Librarians</a></li>
            <li class="navList__route"><a href="{% url 'libraryapp:logout' %}">Logout</a></li>
        </ol>
    </nav>

    <main class="main-content">
        {% block content %}
        {% endblock %}
    </main>

    {% block scripts %}
    {% endblock scripts %}
</body>

</html>
```

## Book List Styles

Next step is to create a CSS file to style the book list. Create a `styles/books.css` and place the following code in it.

```css
.books {
    list-style: none;
    display: flex;
    flex-wrap: wrap;
    justify-content: space-evenly;
}

.book {
    flex-basis: 20%;
    padding: 0 2em 0.5em 2em;
    border: 1px solid gray;
    margin: 1em;
    padding: 1.5em;
}

.book__title {
    font-size: 1.1em;
}

.book__description {
    font-size: 0.75em;
}
```

Also update the book list template to request the `books.css` file, and include all those classes. In a derived template, you also need to `{% load staticfiles %}` to use static files in your application, even though the base template also had that instruction in it.

```jinja
{% extends 'shared/base.html' %}
{% load staticfiles %}

{% block css %}
    <link rel="stylesheet" href="{% static 'styles/books.css' %}" />
{% endblock %}

{% block content %}
    <h1>Books</h1>

    <a href="{% url 'libraryapp:book_form' %}">Add Book to Inventory</a>

    <ol class="books">
    {% for book in all_books %}
        <li class="book">
            <a class="book__title" href="{% url 'libraryapp:book' book.id %}"> {{ book.title }}</a>
            <div class="book__description">
                by {{book.author}} published in {{book.year_published}}
            </div>
        </li>
    {% endfor %}
    </ol>
{% endblock %}
```

The end result should be a slightly better looking book list view that uses Flexbox to create a grid layout for the books.

![](./images/book-list-view-styled.png)
