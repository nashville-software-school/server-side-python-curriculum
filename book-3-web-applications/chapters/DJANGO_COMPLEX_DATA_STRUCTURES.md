# Using Joined Models in Views and Templates

Up to now, when you have rendered an individual resource, you have only shown the values of that resource's columns in the database. For example, when viewing the details of a book, you showed the following.

1. Title
1. Author
1. ISBN
1. Year published

That is not all of the information that can be displayed. A book is contained in a specific library and it was added to the inventory by a specific librarian. Those additional details must be retrieved by joining in the corresponding **Library** and **Librarian** entries via the foreign keys in each row.

## Joining Related Data to a Single Item

Time to refactor the detail view of a Book to show which library it is in and which librarian added it.

### Updated Row Factory

Open the view file and put in the following row factory function.

> #### libraryproject/libraryapp/views/books/details.py

```py
def create_book(cursor, row):
    _row = sqlite3.Row(cursor, row)

    book = Book()
    book.id = _row["book_id"]
    book.author = _row["author"]
    book.isbn = _row["isbn"]
    book.title = _row["title"]
    book.year_published = _row["year_published"]

    librarian = Librarian()
    librarian.id = _row["librarian_id"]
    librarian.first_name = _row["first_name"]
    librarian.last_name = _row["last_name"]

    library = Library()
    library.id = _row["library_id"]
    library.title = _row["library_name"]

    book.librarian = librarian
    book.location = library

    return book
```

### Join Library and Librarian

Now you need to update your `get_book()` function to include the appropriate JOIN clauses to get the details of the associated library and librarian. It also needs to use your new row factory function.

> #### libraryproject/libraryapp/views/books/details.py

```py
def get_book(book_id):
    with sqlite3.connect(Connection.db_path) as conn:
        conn.row_factory = create_book
        db_cursor = conn.cursor()

        db_cursor.execute("""
        SELECT
            b.id book_id,
            b.title,
            b.isbn,
            b.author,
            b.year_published,
            b.librarian_id,
            b.location_id,
            li.id librarian_id,
            u.first_name,
            u.last_name,
            loc.id library_id,
            loc.title library_name
        FROM libraryapp_book b
        JOIN libraryapp_librarian li ON b.librarian_id = li.id
        JOIN libraryapp_library loc ON b.location_id = loc.id
        JOIN auth_user u ON u.id = li.user_id
        WHERE b.id = ?
        """, (book_id,))

        return db_cursor.fetchone()
```

### Displaying Library and Librarian Details in Template

In the `detail.html` template for your book, update the book info section to use the new properties on the book.

```jinja
<section id="book-details">
    <h1>{{ book.title }}</h1>
    <h2>By {{ book.author }}</h2>

    <div>Published in {{ book.year_published }}</div>
    <div>ISBN: {{ book.isbn }}</div>
    <div>Located in the {{ book.location.title }}</div>
    <div>Registered by {{ book.librarian.first_name }} {{ book.librarian.last_name }}</div>
</section>
```

### Demo

Once this code is in place, you should now see the librarian and library assigned to the book.

![animation showing details of several books with related data included](./images/books-with-related-data.gif)

## Joining Related Data on a Collection of Items

Things get even more complex when you want to display a list of resources - such as Liraries - and show their related data. Each library has multiple books in its inventory. Since you cannot use SQL to generate complex structures _(it only give you flat data back)_ then the Python developer is responsible for converting the flat data into grouped data.

Use this query to get all libraries and their related books in TablePlus.

```sql
SELECT
	li.id library_id,
	li.title,
	li.address,
	b.id book_id,
	b.title,
	b.author,
	b.year_published,
	b.isbn
FROM libraryapp_library li
JOIN libraryapp_book b ON li.id = b.location_id
;
```

You will see that the consequence of joining in the books that are assigned to each library is that there are now as many rows in the data set as there are books. That's all that SQL can produce - flat rows. It can't group them together into complex data structures like tuples, lists, or dictionaries.

![](./images/books-per-library.png)

Now take that SQL statement and use it in the `library_list()` function in your view.

> #### libraryproject/libraryapp/views/libraries/list.py

```py
@login_required
def library_list(request):
    if request.method == 'GET':
        with sqlite3.connect(Connection.db_path) as conn:
            conn.row_factory = model_factory(Library)
            db_cursor = conn.cursor()

            db_cursor.execute("""
                SELECT
                    li.id,
                    li.title,
                    li.address,
                    b.id book_id,
                    b.title book_title,
                    b.author,
                    b.year_published,
                    b.isbn
                FROM libraryapp_library li
                JOIN libraryapp_book b ON li.id = b.location_id
            """)

            libraries = db_cursor.fetchall()

        template = 'libraries/list.html'
        context = {
            'all_libraries': libraries
        }

        return render(request, template, context)
```

### Too Many Libraries

As soon as you put that query into your view and visit your library list in the browser, you immediately see the problem. The number of libraries displayed is now dependent upon how many books there are in the system since the data is not grouped... it's flat.

![](./images/too-many-libraries.png)

### Just the Right Amount of Libraries

The output you want to present to users is a list of libraries, with a sub-list of books in that library.


![](./images/library-list-with-books.png)

To accomplish this, you must do several complex refactors of your library list view, and your library list template. Start with the view. Add the following row factory function to your library list view.

```py
def create_library(cursor, row):
    _row = sqlite3.Row(cursor, row)

    library = Library()
    library.id = _row["id"]
    library.title = _row["title"]
    library.address = _row["address"]

    # Note: You are adding a blank books list to the library object
    # This list will be populated later (see below)
    library.books = []

    book = Book()
    book.id = _row["book_id"]
    book.title = _row["book_title"]
    book.author = _row["author"]
    book.isbn = _row["isbn"]
    book.year_published = _row["year_published"]

    # Return a tuple containing the library and the
    # book built from the data in the current row of
    # the data set
    return (library, book,)
```

Then update your `library_list()` view to use that row factory.

```py
def library_list(request):
    if request.method == 'GET':
        with sqlite3.connect(Connection.db_path) as conn:
            conn.row_factory = create_library
```

After you refactor this code, when you invoke the `fetchall()` method on the database cursor, you end up with a list of tuples.


Then you need to group the books into each library yourself. Here's an example of how to do that.

```py
# Start with an empty dictionary
library_groups = {}

# Iterate the list of tuples
for (library, book) in libraries:

    # If the dictionary does have a key of the current
    # library's `id` value, add the key and set the value
    # to the current library
    if library.id not in library_groups:
        library_groups[library.id] = library
        library_groups[library.id].books.append(book)

    # If the key does exist, just append the current
    # book to the list of books for the current library
    else:
        library_groups[library.id].books.append(book)

```
