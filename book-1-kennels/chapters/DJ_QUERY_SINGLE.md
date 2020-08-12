# Single Journal Entries

## Handling GET Requests for Single Entries

1. Have your server listen for the http://localhost:8088/entries/{integer} URL by parsing the URL and checking if there is a route parameter.
1. Write a `get_single_entry()` function in the entries request module and write the SQL, with a parameter, to get a single record from the Entries table.
1. If the resource is `entries` return all records from database as JSON representations.

## Test in Postman

For now, test that you can get a single journal entry in Postman. This method will be useful in the client later when you implement editing.