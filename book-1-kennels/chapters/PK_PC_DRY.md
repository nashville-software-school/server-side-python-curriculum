# Getting Tired of Writing the Same Old Code?

## Reading Material

Read these articles before you try the code, or after. They are provided to begin the process of getting a deeper understand of software.

* [OOP Concept for Beginners: What is Abstraction?](https://stackify.com/oop-concept-abstraction/)
* [3 Key Software Principles You Must Understand](https://code.tutsplus.com/tutorials/3-key-software-principles-you-must-understand--net-25161)

## Problem

Here's a block of code that shows what your `do_GET` method might look like right now. You likely have already noticed that the exact same logic gets repeated over, and over, and over again, but different functions get invoked depending on the resource requested.

```py
def do_GET(self):
    response = None
    (resource, id) = self.parse_url(self.path)

    if resource == "animals":
        if id is not None:
            response = get_single_animal(id)

            if response is not None:
                self._set_headers(200)
            else:
                self._set_headers(404)
                response = ''
        else:
            self._set_headers(200)
            response = get_all_animals()

    elif resource == "customers":
        if id is not None:
            response = get_single_customer(id)

            if response is not None:
                self._set_headers(200)
            else:
                self._set_headers(404)
                response = ""
        else:
            self._set_headers(200)
            response = get_all_customers()


    elif resource == "locations":
        if id is not None:
            response = get_single_location(id)

            if response is not None:
                self._set_headers(200)
            else:
                self._set_headers(404)
                response = ""
        else:
            self._set_headers(200)
            response = get_all_locations()


    elif resource == "employees":
        if id is not None:
            response = get_single_employee(id)

            if response is not None:
                self._set_headers(200)
            else:
                self._set_headers(404)
                response = ""
        else:
            self._set_headers(200)
            response = get_all_employees()

```

Now consider that over the next year, 5 new resources are slated to be supported by your API. This block of code would become even more redundant and cumbersome. So much repeated code.

## DRY and Abstraction

What if we told you that all of that can be condensed into the following code?

```py
def do_GET(self):
    response = None
    (resource, id) = self.parse_url(self.path)
    response = self.get_all_or_single(resource, id)
    self.wfile.write(json.dumps(response).encode())
```

Whenever you find yourself writing the exact, or nearly exact, same code over and over again, it's an opportunity to write a function. Here is the new function that was added to the class.

You can see that the verbose logic of the previous code has been simplified into a single `if..else` statement, and the resource and id values are now being passed as arguments to the function. This allows the code to scale to as many resources as are needed without needing to duplicate the same code block over and over again.

```py
def get_all_or_single(self, resource, id):
    if id is not None:
        response = method_mapper[resource]["single"](id)

        if response is not None:
            self._set_headers(200)
        else:
            self._set_headers(404)
            response = ''
    else:
        self._set_headers(200)
        response = method_mapper[resource]["all"]()

    return response
```

## Method Mapper

The only remaining mystery is the `method_mapper`. All we will tell you is that it's a dictionary, and that function references can be the value of a key in a dictionary.

```py
def example(custom_text):
    return { "prompt": f"Descriptive message: {custom_text}" }

method_mapper = {
    "test": example
}

prompt = method_mapper["test"]("Hi there")
```

Use your powers of deduction, debugging, and algorithmic thinking to see if you can build the correct data structure. Here's where it should go - right above the class definition.

```py
method_mapper = { }


class HandleRequests(BaseHTTPRequestHandler):
    ...
```
