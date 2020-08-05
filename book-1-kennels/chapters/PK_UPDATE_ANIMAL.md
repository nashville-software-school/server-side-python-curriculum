# Modifying Animal Status

A small refactor to start this chapter.

Open your `animals/request.py` module, and add a new `status` key to each of your animal dictionaries.

```py
{
    "id": 2,
    "name": "Gypsy",
    "species": "Dog",
    "location": 1,
    "customerId": 2,
    "status": "Admitted"
}
```

In this chapter, you are going to make your Python server handle the PUT request to that employees can update the status of an animal.

## Handle PUT Request

Place the following method to the **`HandleRequests`** class in the main module.

```py
def do_PUT(self):
    self._set_no_content_headers()
    content_len = int(self.headers.get('content-length', 0))
    post_body = self.rfile.read(content_len)
    post_body = json.loads(post_body)

    # Parse the URL
    (resource, id) = self.parse_url(self.path)

    # Delete a single animal from the list
    if resource == "animals":
        update_animal(id, post_body)

    # Encode the new animal and send in response
    self.wfile.write("".encode())
```

## Replacing Dictionary with New One

In `animals/request.py` add the following function which iterates the list of animals until it finds the right one, and then replaces it with what the client sent as the replacement.

```py
def update_animal(id, new_animal):
    # Iterate the ANIMALS list, but use enumerate() so that
    # you can access the index value of each item.
    for index, animal in enumerate(ANIMALS):
        if animal["id"] == id:
            # Found the animal. Update the value.
            ANIMALS[index] = new_animal
            break
```

Import this new function into the `animals/__init__.py` module, and then into the `request_handler.py` module.