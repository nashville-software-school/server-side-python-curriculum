# Designing Your Database

Time to revisit many-to-many relationships and create your ERD for the Reader's Digest API project. Here are the requirements for the database. Your job is to design the ERD in dbDiagram.

* You will be using the Django **User** to track users and authentication in this application.
* There will be multiple book categories. Each category will have a _name_ field.
* Users will create books in the system that they have read. It must store the following properties of a book.
  * Title
  * Author
  * ISBN number
  * Cover image URL
  * Authenticated user
  * Categories for book
* A book can be assigned to many categories, and a single category can be assigned to many books.
* Authenticated users can review any book in the system with the following information tracked in the database.
  * Book being reviewed
  * Authenticated user
  * Numeric rating from 1-10
  * A text comment for the review
  * Date posted must be handled by the database. User will not choose date when writing review.
* The intersection table should store the relationship between books and categories, and also have a timestamp of when the relationship was created.

Once you have created the ERD, you can review with teammates or instructors if you are unsure about your design, and then move on to create the models.

## Django Models

> 🧨 Before moving on make sure you have defined all of the models for each table you defined in your ERD. It is required before reading on.

## Book Model

As you define your models it's time to learn how Django makes it easy for developers to create and manage many-to-many relationships in the database. Remember the the intersection table is what stores the **actual** relationships between books and categories. However, when you have an instance of a **Book** class, it can be tedious to traverse the intersection table, then to the **Category** table to find all of the categories assigned to the book.

Look at the Book model below and focus on the `categories` field.

> #### `digestapi/models/book.py`

```py
from django.db import models
from django.contrib.auth.models import User


class Book(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="books_created")
    title = models.CharField(max_length=200)
    author = models.CharField(max_length=200)
    isbn_number = models.CharField(max_length=13, null=True, blank=True)
    cover_image = models.URLField(null=True, blank=True)
    categories = models.ManyToManyField(
        "Category",
        through='BookCategory',
        related_name="books"
    )
```

> 🧨 It is important to note that `categories` is not an actual field in the database. It is a property that exist on instances of **Book** that will automatically contain all of the related categories for the book.

The first argument is the name of the table that is the other side of the many-to-many relationship - **Category**.

The second argument tells Django which model will store those relationships - **BookCategory**.

The third argument is what property will be added to instances of the **Category** model to contain a list of related books - **books**.

## Creating the Tables

Make sure all of your models are imported into the package first. Once that is done, run the following command in your project directory.

```sh
python3 manage.py makemigrations
```

After the migration file is created, then execute it to create the tables.

```sh
python3 manage.py migrate
```
