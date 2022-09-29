# Getting Single Jewelry Resources

Building on what you did in Kennels, you need to augment each of your handler modules to access an individual resource, or dictionary, in the list at the top of the module.

## Parsing the URL

In order to do this, you need to start parsing the URL. If the URL is http://localhost:8088/metals/1, you need to know both the resource - "metals" - and the id of the requested resource - "1".

Copy pasta the `parse_url()` function from Kennels to your `request_handler` module for this project. Make sure it's in the scope of the class.

## Check For What Was Requested

Now the `do_GET` function needs to be augmented to use the `parse_url` function, just like in Kennels.

Start with metals.

```py
def do_GET(self):
    """Handles GET requests to the server """
    self._set_headers(200)

    response = {}  # Default response

    # Parse the URL and capture the tuple that is returned
    (resource, id) = self.parse_url(self.path)

    if resource == "metals":
        if id is not None:
            response = get_single_metal(id)

        else:
            response = get_all_metals()

```

## Single Getters

For example, here's some code to get you started to get a single metal.

```py
# Function with a single parameter
def get_single_metal(id):
    # Variable to hold the found metal, if it exists
    requested_metal = None

    # Iterate the METALS list above. Very similar to the
    # for..of loops you used in JavaScript.
    for metal in METALS:
        # Dictionaries in Python use [] notation to find a key
        # instead of the dot notation that JavaScript used.
        if metal["id"] == id:
            requested_metal = metal

    return requested_metal
```

Add a similiar function to every handler and test that you can get a single resource. Again, use Postman or your favorite API client tool.

<img src="./images/KD_GET_SINGLE_RESOURCES.gif" width="700px" alt="Animation showing a GET request and response for a single metal resource" />