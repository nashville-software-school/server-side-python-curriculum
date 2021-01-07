# Getting a Single Animal

In this chapter, you are going to write another function in your `animals/request.py` module, and also see your first `for..in` loop in Python.

## Learning Objectives

* You should be able to demonstrate how to use arguments and function parameters in Python.
* You should be able to identify different parts of a URL path.
* You should be able to explain the difference between a list and a tuple.
* You should be able to identify a Python expression where a tuple is unpacked.
* You should be able to implement the `int()` Python function to convert a string to an integer.
* You should be able to explain how `try/except` blocks work in Python.

## Reading Resources

* [Unpacking a Tuple in Python](https://www.geeksforgeeks.org/unpacking-a-tuple-in-python/)

## Single Animal Lookup

Copy the function below into your `animals/request.py` module.

```py
# Function with a single parameter
def get_single_animal(id):
    # Variable to hold the found animal, if it exists
    requested_animal = None

    # Iterate the ANIMALS list above. Very similar to the
    # for..of loops you used in JavaScript.
    for animal in ANIMALS:
        # Dictionaries in Python use [] notation to find a key
        # instead of the dot notation that JavaScript used.
        if animal["id"] == id:
            requested_animal = animal

    return requested_animal
```

Notice that the function has a parameter. This makes sense since the responsibility of this function is to look up a single animal, the `id` of the animal has to be passed as an argument.

It iterates the entire list with a `for..in` loop. For each animal, it checks if its `id` property is the same as the id that was passed into the function as a parameter.

Finally, it returns the value of `requested_animal`. It will either be `None`, or the dictionary that it found.

## Getting Route Parameter

In the `request_handler.py` module, the `self.path` property of the incoming request will be everything after the domain.

| Requested URL | Path |
|--|--|
| localhost:8088/animals | /animals  |
| localhost:8088/locations | /locations  |
| localhost:8088/animals/new | /animals/new  |
| localhost:8088/animals/1 | /animals/1  |

Therefore, if a client requests a single animal (_e.g. `/animals/8`_) then you need to isolate the `8` from the whole path string.

## Split and Exceptions and Tuples... Oh My

To accomplish this, you need to add the following `parse_url()` method to the `HandlRequests` class. This method takes a single input - the path of the request - and returns a tuple.

A tuple is a specialized list in Python. What makes it difference is that it is immutable - meaning is cannot be changed after it is created. You can't add things, remove things, or change the position of anything in it.

```py
class HandleRequests(BaseHTTPRequestHandler):
    def parse_url(self, path):
        # Just like splitting a string in JavaScript. If the
        # path is "/animals/1", the resulting list will
        # have "" at index 0, "animals" at index 1, and "1"
        # at index 2.
        path_params = path.split("/")
        resource = path_params[1]
        id = None

        # Try to get the item at index 2
        try:
            id = int(path_params[2])
        except IndexError:
            pass  # No route parameter exists: /animals
        except ValueError:
            pass  # Request had trailing slash: /animals/

        return (resource, id)  # This is a tuple
```

## All Animals, or a Single Animal

Now you can use this function to determine if the client requested all animals or a single animal.

First, import the `get_single_animal()` function from the animal package.

```py
from animals import get_all_animals, get_single_animal
```

Then update the `do_GET()` function with the following code.

```py
    def do_GET(self):
        self._set_headers(200)
        response = {}  # Default response

        # Parse the URL and capture the tuple that is returned
        (resource, id) = self.parse_url(self.path)

        if resource == "animals":
            if id is not None:
                response = f"{get_single_animal(id)}"

            else:
                response = f"{get_all_animals()}"

        self.wfile.write(response.encode())
```

## Practice: Locations

Now follow the same pattern for location data. Create a `locations` package with a `request.py` module in it. Copy your locations array from the `database.json` file that you used for Nashville Kennel and paste it in at the top of the module and store it in a `LOCATIONS` variable.

Then implement the following two functions in the `locations/request.py` module.

1. `get_all_locations`
1. `get_single_location`

Then add another `if..else` statement to the `do_GET` method in the main module to handle GET requests to `/locations` and `locations/{id}`.

## Practice: Employees

Do the same thing for employee data.

## Practice: Customers

Do the same thing for customer data.