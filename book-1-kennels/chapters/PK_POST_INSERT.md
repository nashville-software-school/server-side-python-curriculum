# Adding Animals to the Database


Previously, when you initiated a POST operation from the Postman client, a new dictionary was added to an in-memory list with the `create_animal()` function. You are going to change that code to insert the new animal into the database.

> #### `animals/request.py`

```py
def create_animal(new_animal):
    with sqlite3.connect("./kennel.db") as conn:
        db_cursor = conn.cursor()

        db_cursor.execute("""
        INSERT INTO Animal
            ( name, breed, status, location_id, customer_id )
        VALUES
            ( ?, ?, ?, ?, ?);
        """, (new_animal['name'], new_animal['species'],
              new_animal['status'], new_animal['location_id'],
              new_animal['customer_id'], ))

        # The `lastrowid` property on the cursor will return
        # the primary key of the last thing that got added to
        # the database.
        id = db_cursor.lastrowid

        # Add the `id` property to the animal dictionary that
        # was sent by the client so that the client sees the
        # primary key in the response.
        new_animal['id'] = id


    return json.dumps(new_animal)
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
1. Add a `saveEmployee()` function to your **`EmployeeProvider`** component.
1. In Python add a `save_employee()` function to the `employees/request.py` module that performs an `INSERT INTO` SQL query to the Employees table.
1. Update the `do_POST()` method in the `request_handler` module in Python to accept POST requests to the `/employees` resource.