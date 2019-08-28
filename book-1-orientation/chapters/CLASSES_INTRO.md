# Classes

## Why are you Learning This?

You are learning about the syntax and usage of classes because when you extract data from a relational database later in the course, each row of data represents the state of certain things, such as a student, a building, a book, or any other real-world object that you want to store data about.

Classes let you define your own, custom type in Python. The current types that you know about are `list`, `dict`, and `set`. These data structure types are very limiting when you need to represent a complex object in code, though.

## Introduction to Classes

Much like Javascript, almost everything in Python is based on objects. The ability to create objects in a predictable, organized way is essential. This is where classes come into play.

A class is like an object constructor, or a blueprint for creating objects. It helps us define the representation of something from the real world, in code. That 'something' is defined by its values and behaviors (properties).

Once a class is defined, you can use it to crank out objects based on the class. We call those objects _instances_ of the class.

![visualization of two instances of the Student class](./images/python-class-instances.png)

To define a class, you begin with the keyword `class` and then define at least an `__init__` method on for the class. The `__init__` method holds the instructions for what to do when a developer makes an instance of your class.

Imagine you want to build a Python application that allows a person to keep track of all of their books in their library. Each book has common properties, and things that can be done with it.

A book has properties such title, publisher, author, and year published.

You can also _do stuff_ with a book. You can read a book. You can put a bookmark it in to save your spot as you read it.

Here's how you would define a template for how each book will be represented in your application.

```py
class Book:

    def __init__(self):
        # Establish the properties of each book
        # with a default value
        self.title = ""
        self.publisher = ""
        self.author = ""
        self.current_page = 1
        self.year_published = 0
        self.currently_reading = False

    def start_reading(self):
        self.currently_reading = True
        print(f'You start reading {self.title} at page {self.current_page}')

    def stop_reading(self, page):
        self.current_page = page
```

To create an instance of the class, you type the name of the class and put parenthesis after it. You should always store the object instance in a variable.

```py
mockingbird = Book()
```

> **Tip:** What's up with that _self_ parameter that is the first argument of all of the methods? It's the instance of the class that you created.

For any class, when you create an instance of it, it executes an internal `__init__` method. In this method, one common thing to do is to define properties that every instance of the class will contain. Time to examine what the value of each of our book's properties are.

Put this code in your module.

```py
for prop, value in mockingbird.__dict__.items():
    print(f'{prop}:\n{value}\n')
```

You will see the following output:

```py
title:


publisher:


author:


current_page:
1

year_published:
0

currently_reading:
False
```

Now define some values for each property.

```py
mockingbird = Book()
mockingbird.title = "To Kill a Mockingbird"
mockingbird.publisher = "Penguin Books"
mockingbird.author = "Harper Lee"
mockingbird.year_published = 1960
mockingbird.publisher = "J. B. Lippincott & Co."

for prop, value in mockingbird.__dict__.items():
    print(f'{prop}:\n{value}\n')
```

Examine the properties again by moving the `for` loop you used earlier to after you have define the properties. You will see the following output.

```py
title:
To Kill a Mockingbird

publisher:
J. B. Lippincott & Co.

author:
Harper Lee

current_page:
1

year_published:
1960

currently_reading:
False
```

Now let's do something with the book. You will start and stop reading the book.

```py
mockingbird = Book()
mockingbird.title = "To Kill a Mockingbird"
mockingbird.publisher = "Penguin Books"
mockingbird.author = "Harper Lee"
mockingbird.year_published = 1960
mockingbird.publisher = "J. B. Lippincott & Co."


print(mockingbird.currently_reading)
mockingbird.start_reading()
print(mockingbird.currently_reading)
mockingbird.stop_reading(34)
mockingbird.start_reading()
mockingbird.stop_reading(89)
mockingbird.start_reading()
```

When you run that code, it produces the output.

```py
False
You start reading To Kill a Mockingbird at page 1
True
You start reading To Kill a Mockingbird at page 34
You start reading To Kill a Mockingbird at page 89
```

### Practice: Pizza Joint

#### Setup

```
mkdir -p ~/workspace/python/exercises/classes && cd $_
touch classes.py
```

#### Instructions
1. Create a **`Pizza`** type for representing pizzas in Python. Think about some basic properties that would define a pizza's values; things like size, crust type, and toppings would help. Define those in the `__init__` method so each instance can have its own specific values for those properties.

1. Add a method for interacting with a pizza's toppings, called `add_topping`.

1. Add a method for outputting a description of the pizza _(sample output below)_.

1. Make two different instances of a pizza. If you have properly defined the class, you should be able to do something like the following code with your Pizza type.

```py
meat_lovers = Pizza()
meat_lovers.size = 16
meat_lovers.style = "Deep dish"
meat_lovers.add_topping("Pepperoni")
meat_lovers.add_topping("Olives")
meat_lovers.print_order()
```
You should produce output in the terminal similiar to the following string.

```sh
"I would like a 16-inch, deep-dish pizza with Pepperoni and Olives."
```

## Class Construction Arguments

The `__init__()` method on a Python class can accept as many arguments as you like. Those arguments can then be used to initialize the properties of each object created from the class. Here's an example.

```py
class Farm:

    def __init__(self, name, acres):
        self.business_name = name
        self.total_acreage = acres


rolling_hills = Farm("Rolling Hills Farm", 325)
```

By passing the property value in during the instantiation of the object, I don't have to manually create the properties on a separate line of code.

```py
# No need to do this!!
rolling_hills.business_name = "Rolling Hills Farm"
rolling_hills.total_acreage = 325
```

### Practice: Urban Planner

#### Setup

```sh
mkdir -p ~/workspace/python/exercises/planner && cd $_
touch building.py
```

In this exercise, you are going to define your own **`Building`** type and create several instances of it to design your own virtual city. Create a class named **`Building`** in the `building.py` file and define the following fields, properties, and methods.

#### Properties

* `designer` - It will hold your name.
* `date_constructed` - This will hold the exact time the building was created.
* `owner` - This will store the same of the person who owns the building.
* `address`
* `stories`

#### Methods

* Define a `construct()` method. The method's logic should set the `date_constructed` field's value to `datetime.datetime.now()`. You will need to have `import datetime` at the top of your file.

* Define a `purchase()` method. The method should accept a single string argument of the name of the person purchasing a building. The method should take that string and assign it to the `owner` property.


#### Constructor

Define your `__init__` method to accept two arguments

1. `address`
2. `stories`

Once defined this way, you can send those values as  parameters when you create each instance

```py
 eight_hundred_eighth = Building("800 8th Street", 12)
 ```

#### Creating Your Buildings

1. Create 5 building instances
1. Have each one get purchased by a real estate magnate
1. After purchased, construct each one
1. Once all building are purchased and constructed, print the address, owner, stories, and date constructed to the terminal for each one.

##### Example

```sh
800 8th Street was purchased by Bob Builder on 03/14/2018 and has 12 stories.
```

## Type Relationships

You can define two types in your system that represent two real-world entities that have a relationship with each other. Consider banks and their customers. What is their relationship?

Customers usually make decisions to have an account at a single bank at a time. A bank can have many customers. This is a one-to-many relationship. In Python, you can establish this relationship by defining a list on the bank object that will contains instances of customers. Consider the following code.

```py
class Bank:

    def __init__(self, name):
        self.business_name = name
        self.customers = list()
```

When you create a bank, you specify the name of it on construction, and it get initialized with an empty list of customers.

```py
first_tennessee = Bank("First Tennessee")
```

Now define a customer.

```py
class Customer:

    def __init__(self, first_name, last_name):
        self.first_name = first_name
        self.last_name = last_name
```

Now you can create a few people who are shopping for a bank.

```py
mo = Customer("Mo", "Silvera")
warner = Customer("Warner", "Carpenter")
ken = Customer("Ken", "Perkerwicz")
```

All three of these people choose First Tennessee as their bank, so add the object references to the `customers` list on the bank.

```py
first_tennessee.customers.append(mo)
first_tennessee.customers.append(warner)
first_tennessee.customers.append(ken)
```

Now the object have a relationship with each other. If you want to view all the customers of a bank, just iterate the `customers` list.

```py
for customer in first_tennessee.customers:
    print(f'{customer.first_name} {customer.last_name} is a customer of {first_tennessee.business_name}')
```

### Practice: Companies and Employees

#### Setup

```sh
mkdir -p ~/workspace/python/exercises/classes && cd $_
touch employees_departments.py
```

#### Instructions

1. Create an **`Employee`** type that contains information about employees of a company. Each employee must have a name, job title, and employment start date.
1. Create a **`Company`** type that employees can work for. A company should have a business name, address, and industry type.
1. Create two companies, and 5 people who want to work for them.
1. Assign 2 people to be employees of the first company.
1. Assign 3 people to be employees of the first company.
1. Output a report to the terminal the displays a business name, and its employees.

For example:

```
Acme Explosives is in the chemical industry and has the following employees
   * Michael Chang
   * Martina Navritilova

Jetways is in the transportation industry and has the following employees
   * Serena Williams
   * Roger Federer
   * Pete Sampras
```
