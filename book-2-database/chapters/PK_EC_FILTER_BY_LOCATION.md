# Filter Animals by Location

For this Explorer chapter, you will need to support the ability of a client to get animals that are assigned to a specific location with a query string parameter.

> GET http://localhost:8088/animals?locationId=1

To do this, you need to add a `WHERE` clause to your SQL statement. Just you did with the `ORDER BY` clause, you will need to do the following.

1. Check if the query string key is "locationId"
2. Build a WHERE clause f-string and interpolate the query string key
    ```py
    where_clause = f"WHERE a.location_id = {qs_value}"
    ```
3. Update your SQL f-string to interpolate **that** value into it.
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
        {where_clause}
        {sort_by}
    """
    ```
