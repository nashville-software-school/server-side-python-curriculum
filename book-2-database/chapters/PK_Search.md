## Optional: Implement Search

Implement the search for the client. Use the a similar SQL query for with the minimum details needed to instanciate the Animals model.

- Users should be able to query on animal name, and breed.
- If any part of the term is included in the string, the animal should be returned to the client

Here is a hint on how to format the search term query:

```py
search_query = f"%{term}%"
```

Read this to learn about SQL Wildcards: https://www.tutorialspoint.com/sql/sql-wildcards.htm