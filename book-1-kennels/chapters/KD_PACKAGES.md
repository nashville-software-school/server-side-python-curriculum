# Packages and Resources

Now it's time to build the directory and file structure for a Kneel Diamonds API.

> For every resource you have in an ERD, you will have a corresponding package in your Python project.

## Directory and Code Setup

Make a new directory in your workspace named `kneel-server`. Then use the commands below.

```sh
cd ~/workspace/kneel-server
touch request_handler.py
curl -L -s 'https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore' > .gitignore
```

## Request Handler Template

Same as you did in Kennels project, place the following starter code in the `request_handler` module.

<details>
    <summary>Expand to get the starter code</summary>

```py
import json
from http.server import BaseHTTPRequestHandler, HTTPServer


class HandleRequests(BaseHTTPRequestHandler):
    """Controls the functionality of any GET, PUT, POST, DELETE requests to the server
    """

    def do_GET(self):
        """Handles GET requests to the server """
        self._set_headers(200)

        if self.path == "/metals":
            response = get_all_metals()

        else:
            response = []

        self.wfile.write(json.dumps(response).encode())

    def do_POST(self):
        """Handles POST requests to the server """
        self._set_headers(201)

        content_len = int(self.headers.get('content-length', 0))
        post_body = self.rfile.read(content_len)
        response = { "payload" : post_body }
        self.wfile.write(json.dumps(response).encode())

    def do_PUT(self):
        """Handles PUT requests to the server """
        self.do_POST()

    def _set_headers(self, status):
        """Sets the status code, Content-Type and Access-Control-Allow-Origin
        headers on the response

        Args:
            status (number): the status code to return to the front end
        """
        self.send_response(status)
        self.send_header('Content-type', 'application/json')
        self.send_header('Access-Control-Allow-Origin', '*')
        self.end_headers()

    def do_OPTIONS(self):
        """Sets the options headers
        """
        self.send_response(200)
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE')
        self.send_header('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type, Accept')
        self.end_headers()



# point of this application.
def main():
    """Starts the server on port 8088 using the HandleRequests class
    """
    host = ''
    port = 8088
    HTTPServer((host, port), HandleRequests).serve_forever()


if __name__ == "__main__":
    main()

```
</details>

## Views Package for Kneel Diamonds

In the Kennels project, you created a directory named `views` that magically became a package when you put a `__init__.py` file inside it. You're going to do the same thing in this project. Do that now.

## Handler Modules

In the Kennels project, you created a module in the `views` directory named `animal_requests.py` that would contain all of the code for handling client requests to `http://localhost:8088/animals`.

Now it's time to think about Kneel Diamonds. What information does the client need access to?

1. Metals
1. Styles
1. Sizes
1. Orders

Therefore, you need a file to contain the logic for each resource needed by a client. Remember the **Single Responsibility Principle**.

Use Kennels as your reference and...

1. Create all four handler modules.
1. Create a list of dictionaries for sample data for each resource at the top of those modules _(Pro Tip: You can actually reference your old Kneel Diamonds client side project snag some data)_.
1. Define a function in each module that returns the entire list.

<details>
    <summary>Some starter code for metals if you want it</summary>

```py
METALS = [
    {
      "id": 1,
      "metal": "Sterling Silver",
      "price": 12.42
    },
    {
      "id": 2,
      "metal": "14K Gold",
      "price": 736.4
    },
    {
      "id": 3,
      "metal": "24K Gold",
      "price": 1258.9
    },
    {
      "id": 4,
      "metal": "Platinum",
      "price": 795.45
    },
    {
      "id": 5,
      "metal": "Palladium",
      "price": 1241
    }
  ]

def get_all_metals():
    return METALS
```
</details>

## Importing your GET Methods

Now that you have modules for handling a GET request for all four resources, make sure the functions are imported into the `views` package. Then import all of them from the views package into the `request_handler` module.

```py
from views import get_all_metals # you do the rest
```

## GET All Resources

In case you didn't notice, we started you off with one condition in your `do_GET` function.

```py
if self.path == "/metals":
    response = get_all_metals()
```

If you named your function `get_all_metals` in the `metals_request.py` module, then you do not need to modify this starter code. Otherwise, update the starter code to match what you called the function.

If you did all the steps required, the make your first request!!

1. Start your project in debug mode.
1. Open Postman and send a GET request to http://localhost:8088/metals.
1. See if you get your metals in the response and that the status code is 200.

Lastly, update your `if..elif..else` block to handle requests for metals, sizes, styles, and orders. Then make requests from Postman _(or your API client of choice)_ to verify your code works correctly.

<img src="./images/KD_GET_ALL_RESOURCES.gif" width="700px" alt="Animation of all responses" />
