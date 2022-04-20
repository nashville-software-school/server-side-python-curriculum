# Modifying Animal Status

## Learning Objectives

* You should be able to explain how to replace an item in a Python list using the index location.
* You should be able to explain the purpose of the PUT method in HTTP requests.
* You should be able to explain the purpose of the `break` keyword in Python.

## Implementation

A small refactor to start this chapter.

Open your `views/animal_requests.py` module, and add a new `status` key to each of your animal dictionaries.

```py
{
    "id": 2,
    "name": "Eleanor",
    "species": "Dog",
    "location": 1,
    "customerId": 2,
    "status": "Admitted"
}
```

In this chapter, you are going to make your Python server handle the PUT request to that employees can update the status of an animal.

## Handle PUT Request

Place the following method to the **`HandleRequests`** class in the main module. Note that the status code is also 204 _(No Content)_ for a PUT request. You need to tell the client that the request was successful, but you don't send back the updated resource.

```py
def do_PUT(self):
    self._set_headers(204)
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

In `views/animal_requests.py` add the following function which iterates the list of animals until it finds the right one, and then replaces it with what the client sent as the replacement.

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

Import this new function into the `__init__.py` module, and then into the `request_handler.py` module.

## Initiate PUT Request from Client

Time to try updating an animal.

1. Open a new tab in Postman.
1. Set the method to `PUT`.
1. Put in the following URL: http://localhost:8088/animals/2
1. Click on the Body section beneath the URL
1. Click on the `raw` radio button that appears.
1. Paste in the following JSON in the text area beneath the radio button.
    ```json
    {
        "id": 2,
        "name": "Eleanor",
        "species": "Dog",
        "location": 1,
        "customerId": 2,
        "status": "Ready for discharge"
    }
    ```
1. Click the Send button.
1. The response code should be `204` and the response text area at the bottom should be blank.
1. Do another `GET` request to http://localhost:8088/animals to see that the animal's status is updated.


![animation of using Postman to update the status of an animal](./images/python-kennel-update-animal.gif)

## Practice: Update Locations, Employees and Customers

Add code to all required modules so that you support PUT operations for the other resource types in your server.
