# Dictionaries

## Explanation
A dictionary in Python is an unordered collection of items where each item is stored as a key-value pair. Dictionaries are mutable, allowing for dynamic updates of their elements. They are defined by enclosing key-value pairs in curly braces `{}`.

## When to Use
Dictionaries are used when you need to associate unique keys with specific values, allowing for fast lookups, updates, and deletions. Common use cases include:
- Storing and accessing data by unique identifiers.
- Maintaining records with named fields (like a simple database).

## Implementation Example
Let's create a simple phonebook application where you can add, remove, and display contacts.

```python
# Initialize an empty phonebook
phonebook = {}

# Function to add a contact
def add_contact(name, number):
    phonebook[name] = number
    print(f"Contact '{name}' added with number {number}.")

# Function to remove a contact
def remove_contact(name):
    if name in phonebook:
        del phonebook[name]
        print(f"Contact '{name}' removed.")
    else:
        print(f"Contact '{name}' not found.")

# Function to display all contacts
def display_contacts():
    print("Phonebook:")
    for name, number in phonebook.items():
        print(f"{name}: {number}")

# Adding contacts
add_contact("Alice", "123-456-7890")
add_contact("Bob", "987-654-3210")
add_contact("Charlie", "555-555-5555")

# Displaying contacts
display_contacts()

# Removing a contact
remove_contact("Bob")

# Displaying contacts again
display_contacts()

# View the entire dictionary
print(phonebook)
```

## Beginner Task: Student Grades Dictionary

Now that you understand how dictionaries work, let's create a simple application to manage a dictionary of student grades. This task will help you practice adding, removing, displaying, and updating items in a dictionary. Follow the instructions below:

### Instructions

1. **Initialize an Empty Dictionary**
   - Create an empty dictionary named `student_grades`.

2. **Add Students and Grades to the Dictionary**
   - Write a function `add_student(name, grade)` that adds a student and their grade to the dictionary and prints a message indicating the student was added.

3. **Remove Students from the Dictionary**
   - Write a function `remove_student(name)` that removes a student from the dictionary if they exist, and prints a message indicating the student was removed or a message if the student was not found.

4. **Display All Students and Their Grades**
   - Write a function `display_students()` that prints all the students and their grades.

5. **Update a Student's Grade**
   - Write a function `update_grade(name, grade)` that updates the grade of a student if they exist, and prints a message indicating the grade was updated or a message if the student was not found.

### Starter Code

Create a module named `gradebook.py` and start with the code below.

```python
# Initialize an empty dictionary of student grades
student_grades = {}

# Function to add a student and grade
def add_student(name, grade):
    pass

# Function to remove a student
def remove_student(name):
    pass

# Function to display all students and their grades
def display_students():
    pass

# Function to update a student's grade
def update_grade(name, grade):
    pass

# Add some students

# Display students and their grades

# Update a student's grade

# Remove a student

# Display students and their grades again
```

## Optional Gradebook Challenges

Want to build more complex functionality? Implement the following features. Otherwise, move on.

- **Find a Student's Grade**: Write a function `find_grade(name)` that checks if a student is in the dictionary and prints their grade if found, or a message if the student was not found.
- **Calculate Average Grade**: Write a function `average_grade()` that calculates and prints the average grade of all students in the dictionary.

## Optional Advanced Challenge: Stock Portfolio

Want to practice your algorithmic thinking skills with Python syntax? Try the challenge below. Otherwise, move on.

A block of publicly traded stock has a variety of attributes. Let's look at a few of them. A stock has a ticker symbol and a company name. Create a simple dictionary with ticker symbols as keys, and company names as values.

### Setup

```
mkdir -p ~/workspace/python/exercises/stocksChallenge && cd $_
touch stocks.py
```

##### Example

```py
ticker_symbols = {
    "GM": "General Motors",
    "CAT":"Caterpillar",
    "EK":"Eastman Kodak"
}
```

Next, you need to make a list of tuples. The list represents the collection of all stock purchases by an important client. Each tuple in the list represents a single purchase.

What to store in the tuple:

```py
(ticket symbol, shares purchased, date of purchase, share price)
```

#### Example

Below is a list you can start with. Add about 10 more purchases of stocks. Make sure there are some stocks purchased multiple times.

```py
purchases = [
    ( 'GE', 100, '10-sep-2001', 48 ),
    ( 'CAT', 100, '1-apr-1999', 24 ),
    ( 'GE', 200, '1-jul-1998', 56 )
]
```

Create a purchase history report that computes the full purchase price (shares times dollars) for each stock purchase and uses the `ticker_symbols` dictionary to look up the full company name.

#### Example output

```
List of all purchases
---------------------
General Electric stock purchased for for $4800
Caterpillar stock purchased for for $2400
General Electric stock purchased for for $11200
```

## Grouping Stock Purchases and Total Value

Create a second purchase summary that accumulates total investment by ticker symbol. In the above sample data, there are two purchases of GE. Create a dictionary where, for each company, the ticker symbol is the key, and the value is a list of all purchases of that company's stock.

#### Example

```py
{
    'GE': [('GE', 100, '10-sep-2001', 48), ('GE', 200, '1-jul-1998', 56)]
}
```

Once that dictionary is created and stores all purchases, iterate the key/value pairs of the dictionary to generate a report that matches the format of the following output.

#### Example output

```haml
* GE Holdings: $16000
* CAT Holdings: $2400

Portfolion Total
----------------
Total value of stock in portfolio: $18400
```
