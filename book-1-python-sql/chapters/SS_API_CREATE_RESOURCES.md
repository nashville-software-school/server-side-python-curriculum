# Support POST Operations

If you look in the `json-server.py` module, you will notice this block of code.

```py
def do_POST(self):
    """Handle POST requests from a client"""

    pass
```

Your job is to follow the same pattern that is being used for GET, PUT, and DELETE operations to allow a client to create a ship, hauler, or dock. You will be using the `INSERT INTO` statement for this operation. Open each of your view files and add a new function for creation operations.

Make sure that this methods accept the POST data as a parameter, just like the update methods do.
