# Editing Resources

It's time to revisit editing resources in a database via user interactions in the browser - everyone's favorite part of NSS. ❤️

Here's the process, which is slightly different that doing it in a single page application like you did in the client-side course.

## Process for Editing a Resource

1. Place an edit button on the detail view of the resource by modifying the template. The button should be in a form along with a hidden input field specifying the action.
1. Code in the view will check for the hidden input field of `actual_method` and see if its value is "EDIT".
1. The view will then query the database for the single record to be edited.
1. The server will return a template, with the single resource object in its context.
1. The template will populate the `value` attribute of all of the input field with their corresponding value from the context's resource object.
1. Once the user has changed the values, and clicks the Update button, the form will be submitted to the detail view for the resource.
1. The view will then check for the `actual_method` field again, and see if its value is "PUT".
1. Then the view will perform an UPDATE statement in the database, and then redirect the user back to the detail view.

Let's start.

### The Edit Button

Add the following code to your `templates/books/detail.html` template.

```html
<form action="{% url 'libraryapp:book_details' book.id %}" method="POST">
    {% csrf_token %}
    <input type="hidden" name="actual_method" value="EDIT">
    <button>Edit</button>
</form>
```

Then add this condition to the POST handler in `views/books/details.py`.

```py
if (
    "actual_method" in form_data
    and form_data["actual_method"] == "EDIT"
):
    book = get_book(book_id)
    libraries = get_libraries()
    template_name = 'books/create.html'
    return render(request, template_name, {'book': book, 'all_libraries': libraries})
```

You are reusing the form that is used to create a book, but this time, you are binding a context dictionary to the template.


Python is very forgiving. If the `book` object is not in the context dictionary for the template, then the form fields will not be populated with a value, even though the code explicitly accesses a property on an object that does not exist. You might expect an exception to be thrown, but it does not.
