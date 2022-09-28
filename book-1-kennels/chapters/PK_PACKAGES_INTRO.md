# Modularizing Animal Data Responses

Having the animal data hard-coded right inside the main Python file, as you might imagine, is a horrible idea. If you kept that up, you would have 1000's of line of code in a single file.

## Learning Objectives

1. You should be able to identify a Python package.
1. You should be able to explain what turns a directory into a Python package.
1. You should be able to identify a Python import of another module.
1. You should be able to discuss the difference in syntax between JavaScript imports and Python imports.


## Gather Related Files into a Package

A package in Python is just a directory with a certain file in it.

That directory needs to have a file called `__init__.py` in it. It's that file, with its weird name, that magically makes a directory into a package.

You may recall in JavaScript that if you wanted to import a module into another one, you had to specify the file path as well as the file name.

```js
import { AwesomeComponent } from "./awesome/list/AwesomeComponent.js"
```

With Python packages, you don't need to do that. You can combine all of the files in sub-directories, and sub-directories of sub-directories, into a single _namespace_.

Time to see what that all means.

```sh
mkdir views
touch views/__init__.py
touch views/animal_requests.py
```

Place the following code into the `views/animal_requests.py` file.

```py
ANIMALS = [
    {
        "id": 1,
        "name": "Snickers",
        "species": "Dog",
        "locationId": 1,
        "customerId": 4
    },
    {
        "id": 2,
        "name": "Roman",
        "species": "Dog",
        "locationId": 1,
        "customerId": 2
    },
    {
        "id": 3,
        "name": "Blue",
        "species": "Cat",
        "locationId": 2,
        "customerId": 1
    }
]


def get_all_animals():
    return ANIMALS
```

This Python module has one method defined in it, and you want to make that method available to any other Python code. To do that, you import it into the `__init__.py` module.

> #### `views/__init__.py`

```py
from .animal_requests import get_all_animals
```

## Importing a Package Methods

Now you can import that function to be used in the main module. Put the new import statement shown below at the top of the file below the existing import statement.

> #### `request_handler.py`

```py
from http.server import BaseHTTPRequestHandler, HTTPServer
from views import get_all_animals
```

## Using Imported Method

Replace the following code...

> #### `request_handler.py`

```py
if self.path == "/animals":
    response = [
        { "id": 1, "name": "Snickers", "species": "Dog" },
        { "id": 2, "name": "Lenny", "species": "Cat" }
    ]

else:
    response = []
```

with this code...

```py
if self.path == "/animals":
    response = get_all_animals()
else:
    response = []
```

Remember that whitespace matters in Python. The indentation level of your code determines which scope it is in. Ensure that the code above is one level of indentation further inside the `do_GET` function.

Make the GET request from Postman and ensure that you get the list of all three animal dictionaries in the response as JSON.

## Preparing for Locations and Employees

To prepare for other resources being available in `kennels-server`, make the `location_requests` and `employee_requests` files within the `views` directory now.

## Back Up Your Code

Now would be a great time to create a `kennels-server` repository on your Github account and hook up your local directory and push your code up.
