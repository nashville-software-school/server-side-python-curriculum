# Using Joined Models in Views and Templates

Up to now, when you have rendered an individual resource, you have only shown the values of that resource's columns in the database. For example, when viewing the details of a book, you showed the following.

1. Title
1. Author
1. ISBN
1. Year published

That is not all of the information that can be displayed. A book is contained in a specific library and it was added to the inventory by a specific librarian. Those additional details must be retrieved by joining in the corresponding **Library** and **Librarian** entries via the foreign keys in each row.

Time to refactor the detail view of a Book to show which library it is in and which librarian added it.

## Complex Row Factory

Open the view file and put in the following row factory function.

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

## Join Library and Librarian

Now you need to update your `get_book()` function to include the appropriate JOIN clauses to get the details of the associated library and librarian. It also needs to use your new row factory function.

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

## Displaying Library and Librarian Details in Template

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

## Demo

Once this code is in place, you should now see the librarian and library assigned to the book.

![animation showing details of several books with related data included](./images/books-with-related-data.gif)
