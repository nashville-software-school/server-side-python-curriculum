# Ch.10 Customers by Email

## Handling Query String Parameters

In this chapter, you will learn how to parse a URL to capture any query string parameters that may be in it, and then use those parameters to filter a SQL query.

## Learning Objectives

- You should be able to define a query string parameter.
- You should be able to identify a query string parameter.
- You should be able to explain how query string parameters are parsed from the URL path.
- You should be able to explain the purpose of the `WHERE` clause in a SQL query.
- You should be able to implement a `WHERE` clause in a SQL query.
- You should be able to identify a SQL parameter.
- You should be able to explain the purpose of a SQL parameter.
- You should be able to use a query string parameter, in conjuntion with a SQL parameter to correctly filter the results of a SQL query.

## Map of the URL

The Uniform Resource Locator _(URL)_ has several parts that allow every resource on the World Wide Web to have a unique identifier, and allow for filtering of resources with parameters.

![](./images/url-parts.png)

## Goal: Find a Customer by Email Address

Get ready, because to do this task, the code is about to get significantly more complex.

To get a customer resource by its email field - because you don't know its unique identifier - you would use a query string parameter.

http://localhost:8088/customers?email=jenna@solis.com

To get a customer by its name field - because you don't know its unique identifier - you would use a different query string parameter.

http://localhost:8088/customers?name=Jenna+Solis

This makes parsing the URL more difficult.

1. Is there a question mark in the resource? If so, that means there is a query string parameter.
1. Split on the `?` to separate `customers` from `email=jenna@solis.com`.
1. Then split on the `=` to get the parameter name and property value separated as `[ 'email', 'jenna@solis.com' ]`.
1. If there isn't a query string, you still have to check if there is a route parameter at the end, and parse that like you have been.

Update the `parse_url()` method in the main module with the code below.

> ##### `request_handler.py`

```py
    def parse_url(self, path):
        path_params = path.split("/")
        resource = path_params[1]

        # Check if there is a query string parameter
        if "?" in resource:
            # GIVEN: /customers?email=jenna@solis.com

            param = resource.split("?")[1]  # email=jenna@solis.com
            resource = resource.split("?")[0]  # 'customers'
            pair = param.split("=")  # [ 'email', 'jenna@solis.com' ]
            key = pair[0]  # 'email'
            value = pair[1]  # 'jenna@solis.com'

            return ( resource, key, value )

        # No query string parameter
        else:
            id = None

            try:
                id = int(path_params[2])
            except IndexError:
                pass  # No route parameter exists: /animals
            except ValueError:
                pass  # Request had trailing slash: /animals/

            return (resource, id)
```

Whew.

Ok, so if you thought that code was intense, now you need to refactor the `do_GET()` method in the main module.

> ##### `request_handler.py`

```py
    def do_GET(self):
        self._set_headers(200)

        response = {}

        # Parse URL and store entire tuple in a variable
        parsed = self.parse_url(self.path)

        # Response from parse_url() is a tuple with 2
        # items in it, which means the request was for
        # `/animals` or `/animals/2`
        if len(parsed) == 2:
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

        # Response from parse_url() is a tuple with 3
        # items in it, which means the request was for
        # `/resource?parameter=value`
        elif len(parsed) == 3:
            ( resource, key, value ) = parsed

            # Is the resource `customers` and was there a
            # query parameter that specified the customer
            # email as a filtering value?
            if key == "email" and resource == "customers":
                response = get_customers_by_email(value)

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

> ##### `customers/request.py`

```py
def get_customers_by_email(email):

    with sqlite3.connect("./kennel.db") as conn:
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
