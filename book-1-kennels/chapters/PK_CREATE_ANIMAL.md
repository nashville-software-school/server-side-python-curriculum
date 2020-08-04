# Creating Animals

In this chapter, you will write code to support the POST method of HTTP. From Postman, you will POST a new object to your Python server. That object will be converted from a string into a Python dictionary, and then added to the `ANIMALS` list in the `animals/request.py` module.

## Using the Built-in JSON package

First, import the `json` package in the Python Standard Libary (_stlib_) at the top of the main module.

```py
import json
```

Back in JavaScript, you could use `JSON.stringify(object)` to convert an object to a string, and `JSON.parse(string)` to convert a JSON string into a JavaScript object.

In Python, you convert a string to a dictionary with `json.loads()`.

Replace the existing `do_POST` method in the main module with the following code.

```py
    def do_POST(self):
        '''Reads post request body'''
        self._set_headers()
        content_len = int(self.headers.get('content-length', 0))
        post_body = self.rfile.read(content_len)

        # Convert JSON string to a Python dictionary
        post_body = json.loads(post_body)

        # Parse the URL
        (resource, id) = self.parse_url(self.path)

        # Initialize new animal
        new_animal = None

        # Add a new animal to the list
        if resource == "animals":
            new_animal = create_animal(post_body)

        # Encode the new animal and send in response
        self.wfile.write(f"{new_animal}".encode())
```

## Appending the Animals List

```py
def create_animal(animal):
    # Get the id value of the last animal in the list
    max_id = ANIMALS[-1]["id"]

    # Add 1 to whatever that number is
    new_id = max_id + 1

    # Add an `id` property to the animal object
    animal["id"] = new_id

    # Add the animal object to the list
    ANIMALS.append(animal)

    # Return dictionary with `id` property added
    return animal
```