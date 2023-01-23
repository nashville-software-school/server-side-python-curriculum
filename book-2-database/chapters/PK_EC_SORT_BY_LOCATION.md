# Sorting Query by Location

## Setup

Open your `request_handler` module and replace the `parse_url` method with the following code. It's been updated to allow you access to query string parameters. The method now returns a tuple with 3 items in it instead of 2.

```py
    def parse_url(self, path):
        url_components = urlparse(path)
        path_params = url_components.path.strip("/").split("/")
        query_params = []

        if url_components.query != '':
            query_params = url_components.query.split("&")

        resource = path_params[0]
        id = None

        try:
            id = int(path_params[1])
        except IndexError:
            pass  # No route parameter exists: /animals
        except ValueError:
            pass  # Request had trailing slash: /animals/

        return (resource, id, query_params)
```

Then add the following import at the top of the file.

```py
from urllib.parse import urlparse
```

You will need to update the code in `request_handler` in many places to make sure that you extract the 3rd item. You should see red squiggles in several places if you scan your code.

Replace...

```py
(resource, id) = parsed
```

with

```py
(resource, id, query_params) = parsed
```

## Guidance

For this Explorer chapter, you are going to support the client sending a query string parameter when requesting all animals. This parameter will ensure that the list in the response is sorted by the `locationId` column.

### Query String Parameter

Here is the URL that you will support for the client to get animals sorted by location.

> GET http://localhost:8088/animals?_sortBy=location

The `?_sortBy=location` part of the URL is the query string parameter.

### Ordering the Query

If the client adds this query string parameter, then your SQL must include an `ORDER BY` clause.

```sql
ORDER BY a.location_id
```

Since you can't use SQL parameters to dynamically change the structure of a query _(they are only used for injecting values)_ then you need to use an f-string to build the SQL string first, and then execute.

Here's how you do it.

1. If you haven't done so yet, update the `do_GET()` method to extract the new, 3rd, item from the tuple that `parse_url()` produces.
    ```py
    ( resource, id, query_params ) = parsed
    ```
1. Pass the query params to the all animals function.
    ```py
    response = get_all_animals(query_params)
    ```
1. Since the `query_params` variable will contain a list of query parameters, you can check if there is one, and extract the key and value. Update the `get_all_animals` function with the following logic.
    ```py
    with sqlite3.connect("./kennel.db") as conn:
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()

        sort_by = ""

        if len(query_params) != 0:
            param = query_params[0]
            [qs_key, qs_value] = param.split("=")

            if qs_key == "_sortBy":
                if qs_value == 'location':
                    sort_by = " ORDER BY location_id"
    ```
1. Take your SQL, make it an f-string and assign it to a variable. Then you can interpolate the `sort_by` variable into the SQL statement.
    ```py
    sql_to_execute = f"""
        SELECT
            a.id,
            a.name,
            a.breed,
            a.status,
            a.location_id,
            a.customer_id,
            l.name location_name,
            l.address location_address
        FROM Animal a
        JOIN `Location` l
            ON l.id = a.location_id
        {sort_by}
    ```
1. Then execute the SQL statement.
    ```py
    db_cursor.execute(sql_to_execute)
    ```

## Testing

Now open your API client and make a GET request to the following URL.

http://localhost:8088/animals?_sortBy=location

Verify that the list of animals is sorted by the `locationId` property, in ascending order.

## Understand

We expect by this point in the course that you are taking the time to use your debugger, discussion with peers, and guidance from your coaches to understand this code. If all you have done to this point is copy pasta, but haven't meticulously stepped through the code to understand the data structures and logic, you need to do it now.