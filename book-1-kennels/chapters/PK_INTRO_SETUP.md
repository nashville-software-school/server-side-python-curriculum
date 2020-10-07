# Replacing json-server with Python

Oh no! The developer of `json-server` decided he didn't want to share his code any longer. This really stinks because all of your local project development was completely dependent on it to be the storage of your persistent data, and allowed you to request the data via `fetch()` calls.

Luckily, you know you have Python installed on your computer and you found a snippet of code on Stack Overflow that lets you start up your own, basic service that listens for HTTP requests on port 8088 - just like `json-server` did - and responds with data.

## Directory and Code Setup

```sh
mkdir -p ~/workspace/python-server
cd ~/workspace/python-server
touch request_handler.py
```

Then copy pasta the following code into the `request_handler.py` file.

```py
from http.server import BaseHTTPRequestHandler, HTTPServer


# Here's a class. It inherits from another class.
class HandleRequests(BaseHTTPRequestHandler):

    # Here's a class function
    def _set_headers(self, status):
        self.send_response(status)
        self.send_header('Content-type', 'application/json')
        self.send_header('Access-Control-Allow-Origin', '*')
        self.end_headers()

    # Here's a method on the class that overrides the parent's method.
    # It handles any GET request.
    def do_GET(self):
        # Set the response code to 'Ok'
        self._set_headers(200)

        # Your new console.log() that outputs to the terminal
        print(self.path)

        # It's an if..else statement
        if self.path == "/animals":
            response = [
                { "id": 1, "name": "Snickers", "species": "Dog" },
                { "id": 2, "name": "Lenny", "species": "Cat" }
            ]

        else:
            response = []

        # This weird code sends a response back to the client
        self.wfile.write(f"{response}".encode())

    # Here's a method on the class that overrides the parent's method.
    # It handles any POST request.
    def do_POST(self):
        # Set response code to 'Created'
        self._set_headers(201)

        content_len = int(self.headers.get('content-length', 0))
        post_body = self.rfile.read(content_len)
        response = f"received post request:<br>{post_body}"
        self.wfile.write(response.encode())


    # Here's a method on the class that overrides the parent's method.
    # It handles any PUT request.
    def do_PUT(self):
        self.do_POST()


# This function is not inside the class. It is the starting
# point of this application.
def main():
    host = ''
    port = 8088
    HTTPServer((host, port), HandleRequests).serve_forever()

if __name__ == "__main__":
    main()
```

## Supporting 3rd Party Software

Now you are going to install two tools:

1. **autopep8** - This is a Python linter (_a linter checks your code for syntax mistakes_).
1. **watchgod** - This will start your application, and then automatically restart it when you make changes to your code.

First, start a virtual environment. Virtual environments ensure that software that install for a project doesn't pollute your entire operating system. It keeps everything contained to the project.

```sh
pipenv shell
```

Once the virtual environment has started, you can install the 3rd-party software.

```sh
pipenv install autopep8 watchgod
```

## Starting python-server

Enter in the following command to start your new data server written in Python.

```sh
watchgod request_handler.main
```

If there are no errors in the code, you will see the following, terse output.

```sh
➜ watchgod request_handler.main
[09:34:37] watching "/Users/.../workspace/python-server" and reloading "request_handler.main" on changes...
```

## Requesting Animals via Postman

Now start Postman and request http://localhost:8088/animals and see what `python-server` responds with. You should get an array of two animal objects.

![animation of postman requesting animals](./images/requesting-animals-postman.gif)