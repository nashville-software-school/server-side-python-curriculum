# Tuples

## Explanation
A tuple in Python is an ordered collection of items that, unlike lists, are immutable. Once created, the elements of a tuple cannot be changed. Tuples are defined by enclosing elements in parentheses `()`.

## When to Use
Tuples are used when you need an immutable sequence of items. Common use cases include:
- Returning multiple values from a function.
- Using fixed collections of items that should not be changed.
- Grouping related data together.

## Implementation Example
Let's create a simple application to manage a library's catalog. This application will:
1. Store book information as tuples.
2. Add new books to the catalog.
3. Display all books in the catalog.
4. Search for books by author.

### Step-by-Step Walkthrough

#### Step 1: Store Book Information
We will start by creating a list to store book information. Each book will be represented as a tuple containing the title, author, and publication year.

```python
# List to store book information
library_catalog = [
    ("To Kill a Mockingbird", "Harper Lee", 1960),
    ("1984", "George Orwell", 1949),
    ("Pride and Prejudice", "Jane Austen", 1813),
    ("The Great Gatsby", "F. Scott Fitzgerald", 1925)
]

# Function to display all books in the catalog
def display_books():
    print("Library Catalog:")
    for title, author, year in library_catalog:
        print(f"Title: {title}, Author: {author}, Year: {year}")

# Displaying the books
display_books()
```

#### Step 2: Add New Books to the Catalog
Next, we'll write a function to add new books to the catalog. This function will take the title, author, and publication year as parameters and append the new book tuple to the catalog.

```python
# Function to add a new book to the catalog
def add_book(title, author, year):
    new_book = (title, author, year)
    library_catalog.append(new_book)
    print(f"Book '{title}' by {author} added to the catalog.")

# Example usage
add_book("The Catcher in the Rye", "J.D. Salinger", 1951)
```

#### Step 3: Search for Books by Author
Finally, we'll write a function to search for books by a specific author. This function will take an author's name as a parameter and return a list of books by that author.

```python
# Function to search for books by an author
def search_by_author(author):
    books_by_author = []
    for book in library_catalog:
        title, book_author, year = book
        if book_author.lower() == author.lower():
            books_by_author.append(book)
    return books_by_author

# Example usage
books_by_orwell = search_by_author("George Orwell")
print("Books by George Orwell:")
for title, author, year in books_by_orwell:
    print(f"Title: {title}, Year: {year}")
```

### Full Example
Here's the complete code for our library catalog management application:

```python
# List to store book information
library_catalog = [
    ("To Kill a Mockingbird", "Harper Lee", 1960),
    ("1984", "George Orwell", 1949),
    ("Pride and Prejudice", "Jane Austen", 1813),
    ("The Great Gatsby", "F. Scott Fitzgerald", 1925)
]

# Function to display all books in the catalog
def display_books():
    print("Library Catalog:")
    for title, author, year in library_catalog:
        print(f"Title: {title}, Author: {author}, Year: {year}")

# Function to add a new book to the catalog
def add_book(title, author, year):
    new_book = (title, author, year)
    library_catalog.append(new_book)
    print(f"Book '{title}' by {author} added to the catalog.")

# Function to search for books by an author
def search_by_author(author):
    books_by_author = []
    for book in library_catalog:
        title, book_author, year = book
        if book_author.lower() == author.lower():
            books_by_author.append(book)
    return books_by_author

# Displaying the books
display_books()

# Adding a new book
add_book("The Catcher in the Rye", "J.D. Salinger", 1951)

# Displaying the books again
display_books()

# Searching for books by George Orwell
books_by_orwell = search_by_author("George Orwell")
print("Books by George Orwell:")
for title, author, year in books_by_orwell:
    print(f"Title: {title}, Year: {year}")
```

## Beginner Task: Movie Collection

Now that you've seen how tuples can be used to store and manage book information, let's create an application to manage a movie collection. This task will help you practice using tuples to store fixed collections of data. Follow the instructions below:

### Instructions

1. **Initialize a List of Movies**
   - Create a list named `movie_collection` where each element is a tuple containing the title, director, and release year.

2. **Add Movies to the Collection**
   - Write a function `add_movie(title, director, year)` that adds a new movie tuple to the list.

3. **Display All Movies**
   - Write a function `display_movies()` that prints all the movies in the collection.

4. **Search for Movies by Director**
   - Write a function `search_by_director(director)` that returns a list of movies by a specific director.


Create a Python module named `my_movies.py` and implement the algorithm.

---

> 🧨 You can move to the [next chapter >>](./PYTHON_EXCEPTIONS.md) or take on the optional challenges below

---

### Optional Challenges

Once you have fulfilled all of the core requirements, you can choose to challenge yourself with the tasks below, or move on to the next chapter.

1. **Remove a Movie from the Collection**
   - Write a function `remove_movie(title)` that removes a movie from the collection by its title.

2. **Update Movie Information**
   - Write a function `update_movie(title, new_director, new_year)` that updates the director and year of a movie in the collection by its title.

3. **Sort Movies by Release Year**
   - Write a function `sort_movies_by_year()` that sorts the movies in the collection by their release year and displays the sorted list.


[Next chapter: Exception Handling >>](./PYTHON_EXCEPTIONS.md)