# Updating a Database Row

In this chapter you will learn how to change the values of columns in an existing database table row.

## Learning Objectives

* You should be able to explain which HTTP method is used by the client to request that a resource's state should change.
* You should be able to identify a SQL query that is changing the state of a row in a database table.
* You should be able to implement multiple SQL parameters in a query.
* You should be able to implement a SQL statement that updates the database with the state that was sent by the client in an HTTP request.

## Videos to Watch First

* [SQL UPDATE Statement |¦| SQL Tutorial |¦| SQL for Beginners](https://www.youtube.com/watch?v=cd-hSl7_pGQ)
* Watch the first 6 minutes of [Update & Delete | SQL | Tutorial 9](https://www.youtube.com/watch?v=rT7BhXLfhds)

## PUT vs PATCH

When the client performs a PUT request to change the values of a current row in your database, it will be sending the **ENTIRE** representation. Not just the one field that it wants to change **unlike PATCH, which only requires the updated values**.

Therefore, you must update each field for the resource based on what the client sends you since you can't possibly know what has changed.

## More Parameters in SQL

In the SQL below, note that there is a `?` parameter for each field in the animal table, and the tuple argument contains the corresponding key in the dictionary that the client sent in the request.

```sql
UPDATE Animal
    SET
        name = ?,
        breed = ?,
        status = ?,
        location_id = ?,
        customer_id = ?
WHERE id = ?
```

The `UPDATE` statement in SQL requires that you specify the new value for the fields of one, or more, resource that you are targeting.

```sql
UPDATE Animal
    SET
        name = ?,
        breed = ?,
        status = ?,
        location_id = ?,
        customer_id = ?
WHERE id = ?
""", (new_animal['name'], new_animal['breed'],
        new_animal['status'], new_animal['locationId'],
        new_animal['customerId'], id, ))

```

Once the `UPDATE` statement executes, you then check to see if a database row was affected. You currently have 5 animals in your database. What if the client sent a request to http://localhost:8088/animals/10345?

There is no animal with that `id` value, so the `rows_affected` variable will be 0. If it is 0, then you know the user specified an `id` that doesn't exist, so you will return `False` which generates a 404 _(Not Found)_ response back to the client.

```py
if rows_affected == 0:
    # Forces 404 response by main module
    return False
else:
    # Forces 204 response by main module
    return True
```

Here is all the code togther so that you can see how it would work in the `update_animal` function.

```py
def update_animal(id, new_animal):
    with sqlite3.connect("./kennel.sqlite3") as conn:
        db_cursor = conn.cursor()

        db_cursor.execute("""
        UPDATE Animal
            SET
                name = ?,
                breed = ?,
                status = ?,
                location_id = ?,
                customer_id = ?
        WHERE id = ?
        """, (new_animal['name'], new_animal['breed'],
              new_animal['status'], new_animal['locationId'],
              new_animal['customerId'], id, ))

        # Were any rows affected?
        # Did the client send an `id` that exists?
        rows_affected = db_cursor.rowcount

    # return value of this function
    if rows_affected == 0:
        # Forces 404 response by main module
        return False
    else:
        # Forces 204 response by main module
        return True
```

In the request_handlers.py do_PUT method you'll need to add a way to handle that returned boolean value

```py
def do_PUT(self):
    content_len = int(self.headers.get('content-length', 0))
    post_body = self.rfile.read(content_len)
    post_body = json.loads(post_body)

    # Parse the URL
    (resource, id) = self.parse_url(self.path)

    # set default value of success
    success = False

    if resource == "animals":
        # will return either True or False from `update_animal`
        success = update_animal(id, post_body)
    # rest of the elif's

    # handle the value of success
    if success:
        self._set_headers(204)
    else:
        self._set_headers(404)

    self.wfile.write("".encode())
 ```
