# Filter Animals by Status

For this Explorer chapter, you will need to support the ability of a client to get animals that have a specific status with a query string parameter.

> GET http://localhost:8088/animals?status=Treatment

Update your `if..else` logic to check for the query string, and build a valid WHERE clause if `status` is the key.
