# Handling Query String Parameters

In this chapter, you will learn how to parse a URL to capture any query string parameters that may be in it, and then use those parameters to filter a SQL query.

## Learning Objectives

* You should be able to define a query string parameter.
* You should be able to identify a query string parameter.
* You should be able to explain how query string parameters are parsed from the URL path.
* You should be able to explain the purpose of the `WHERE` clause in a SQL query.
* You should be able to implement a `WHERE` clause in a SQL query.
* You should be able to identify a SQL parameter.
* You should be able to explain the purpose of a SQL parameter.
* You should be able to use a query string parameter, in conjuntion with a SQL parameter to correctly filter the results of a SQL query.

## Map of the URL

The Uniform Resource Locator _(URL)_ has several parts that allow every resource on the World Wide Web to have a unique identifier, and allow for filtering of resources with parameters.

![](./images/url-parts.png)

## Goal: Find a Customer by Email Address

Get ready, because to do this task, the code is about to get significantly more complex.

To get a customer resource by its email field - because you don't know its unique identifier - you would use a query string parameter.

http://localhost:8088/customers?email=jenna@solis.com

To get a customer by its name field - because you don't know its unique identifier - you would use a different query string parameter.

http://localhost:8088/customers?name=Jenna+Solis

To make it easier to parse the url, we'll use a built in python library. The `urlParse` function will break the url up into it's seperate parts the resource (`/animals` or `/animals/1`) and the query (`email=jenna@solis.com`). Then, if there is a query in the url, it'll use the `parse_qs` function to create a dictionary from the query params. So `email=jenna@solis.com` becomes:
```py
{
  "email": "jenna@solis.com"
}
```

Update the `parse_url()` method in the main module with the code below.

> ##### `request_handler.py`

```py
# add this import to the top of the file
from urllib.parse import urlparse, parse_qs
    
    # replace the parse_url function in the class
    def parse_url(self):
        """Parse the url into the resource and id"""
        parsed_url = urlparse(self.path)
        path_params = parsed_url.path.split('/')  # ['', 'animals', 1]
        resource = path_params[1]

        if parsed_url.query:
            query = parse_qs(parsed_url.query)
            return (resource, query)

        pk = None
        try:
            pk = int(path_params[2])
        except (IndexError, ValueError):
            pass
        return (resource, pk)
```

Next we'll need to refactor the `do_get` so we can call the correct function:

> ##### `request_handler.py`

```py
    def do_GET(self):
        self._set_headers(200)

        response = {}

        # Parse URL and store entire tuple in a variable
        parsed = self.parse_url(self.path)

        # If the path does not include a query parameter, continue with the original if block
        if '?' not in self.path:
            ( resource, id ) = parsed

            if resource == "animals":
                if id is not None:
                    response = f"{get_single_animal(id)}"
                else:
                    response = f"{get_all_animals()}"
            elif resource == "customers":
                if id is not None:
                    response = f"{get_single_customer(id)}"
                else:
                    response = f"{get_all_customers()}"

       else: # There is a ? in the path, run the query param functions
            (resource, query) = parsed
            
            # see if the query dictionary has an email key
            if query.get('email') and resource == 'customers':
                response = get_customer_by_email(query['email'])

        self.wfile.write(response.encode())
```

## Finding the Customer with a WHERE Clause

### Optional Parameters

Before you implement the method to query the database by the email address provided by the client, you need to update your **`Customer`** model to implement default parameter values.

> ##### `models/customer.py`

```py
class Customer():

    def __init__(self, id, name, address, email = "", password = ""):
        self.id = id
        self.name = name
        self.address = address
        self.email = email
        self.password = password
```

The reason for this is because when create some Customer instances to send back the client, sending the password in the response is a bad idea. Also, there's no reason to send the email in the case since the client obviously already has the email address to reference.

Now, you can create an instance of a Customer with only three positional arguments instead of needing all 5.

### Query the Database


In the method that queries the database for customers that have the specified email, it's a simpler query with a single WHERE clause that uses a single SQL parameter.

> ##### `views/customer_requests.py`

```py
def get_customers_by_email(email):

    with sqlite3.connect("./kennel.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()

        # Write the SQL query to get the information you want
        db_cursor.execute("""
        select
            c.id,
            c.name,
            c.address,
            c.email,
            c.password
        from Customer c
        WHERE c.email = ?
        """, ( email, ))

        customers = []
        dataset = db_cursor.fetchall()

        for row in dataset:
            customer = Customer(row['id'], row['name'], row['address'], row['email'] , row['password'])
            customers.append(customer.__dict__)

    return json.dumps(customers)
```

You're going to need to read that all of that code plenty of times, and you'll need to try out different variations of writing it yourself.

Funny... that's exactly what you're about to do.

## Practice: Find Animals by Location

If the client makes the following request...

http://localhost:8088/animals?location_id=1

Then the response should only contain the animals currently registered at that location.

## Practice: Find Employees by Location

If the client makes the following request...

http://localhost:8088/employees?location_id=1

Then the response should only contain the employees currently working at that location.

## Practice: Find Animals by Status

If the client makes the following request...

http://localhost:8088/animals?status=Treatment

Then the response should only the animals currently being treated by the employee, which could include medical care, bathing, nail clipping, etc...

