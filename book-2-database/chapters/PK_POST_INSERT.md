# Adding Animals to the Database

In this chapter, you will learn the step for inserting a new row into a database table.

## Learning Objectives

* You should be able to use SQL to insert data into a database.
* You should be able to determine with SQL operation should be performed for each HTTP method on a request.
* You should be able to diagram how input from a user in the browser is transmitted to a server, then which changes to the database are needed, and then what information the server sends back to the client.
* You should be able to recognize Python code that returns the last primary key that was created in the database.

## HTTP POST -> SQL INSERT

Previously, when you initiated a POST operation from the Postman client, a new dictionary was added to an in-memory list with the `create_animal()` function. You are going to change that code to insert the new animal into the database.

> #### `views/animal_requests.py`

```py
def create_animal(new_animal):
    with sqlite3.connect("./kennel.sqlite3") as conn:
        db_cursor = conn.cursor()

        db_cursor.execute("""
        INSERT INTO Animal
            ( name, breed, status, location_id, customer_id )
        VALUES
            ( ?, ?, ?, ?, ?);
        """, (new_animal['name'], new_animal['breed'],
              new_animal['status'], new_animal['locationId'],
              new_animal['customerId'], ))

        # The `lastrowid` property on the cursor will return
        # the primary key of the last thing that got added to
        # the database.
        id = db_cursor.lastrowid

        # Add the `id` property to the animal dictionary that
        # was sent by the client so that the client sees the
        # primary key in the response.
        new_animal['id'] = id


    return new_animal
```

## Admit Animal in the Postman Client

Once you have implemented this code, use Postman to initiate a POST request to http://localhost:8088/animals just like you did in chapter 4. Verify that it was added by querying the database.

```sql
SELECT * FROM Animals ORDER BY id DESC;
```

By ordering the query by `id` in descending order, you can see the last item entered. It should be the one that you submitted in the POST request.

## Admit Animal in the React Client

Once you have implemented this code, use your Kennel React client application to admit a new animal to one of your locations and verify that it was added by looking at the animal list.

## Optional JavaScript Challenge: Hiring Employees

If you feel like keeping your JavaScript/React skills fresh, feel free to take on this challenge.

1. Add a new **`EmployeeForm`** component to your Kennel client application.
1. Add a `saveEmployee()` function to your **`EmployeeManager`** component.
1. Modify your existing `create_employee()` function in Python to the `views/employee_requests.py` module that performs an `INSERT INTO` SQL query to the Employees table.
