# Expanding Foreign Keys

When you used json-server, it provide the ability to expand foreign keys into full objects representing that related data.

For example, if you requested an unexpanded ship with json-server, you got the following response.

GET http://localhost:8088/ships/1

```json
{
    "id": 1,
    "name": "Algonquin",
    "haulerId": 3
}
```

But if expanded the hauler, it added a new key to the response that had the related data included.

GET http://localhost:8088/ships/1?_expand=hauler

```json
{
    "id": 1,
    "name": "Algonquin",
    "haulerId": 3,
    "hauler": {
        "id": 3,
        "name": "Boaty McBoatface",
        "dockId": 2
    }
}
```

## Supporting Query String Parameters

The code that you are given automatically will extract any query string parameters that exist in the request URL. Time to use a breakpoint and inspect what it looks like when you make a request with a query string parameter.

1. Put a breakpoint in the `do_GET()` method after the URL has been parsed.
2. Go to Postman and request http://localhost:8000/ships?_expand=hauler
3. Go to VS Code and expand the `url` variable in the debugger panel. You will notice that there is a `query_params` key on that dictionary.

The `query_params` key has a value of a dictionary. Each key on that dictionary is the name of a query parameter key _(in this case it is "\_expand")_ and its value is a list. That list contains the value of query string parameter _(in this case, it is "hauler")_.

You will use this to modify your logic. If the query string parameter is there, you will have a more complex JSON response. If the query string parameter is **not** there, your logic will run as it is now.

## Passing the URL Argument

Go to the `list_ships` function in your ship view.

This function will return one of two possible JSON strings. Which one depends on if the query string parameter of `_expand` exist in the URL from the client. Currently the `url` dictionary is not passed as an argument to the `list_ships()` function.

Update your code to pass the entire `url` dictionary from the `do_GET()` method to the `list_ships()` function.

## Using JOIN to Enhance the Response

Now update the code with an `if..else` block. If the `_expand` query string parameter exists, you will perform a different SQL query and build a custom response.

If the parameter is not there, perform the existing logic.

### Client Wants Expanded Ships

If the update query parameter is there, update the SQL in this branch of logic to the following. It has been updated to JOIN the **Hauler** table and get the values for the id, name, and dock_id columns from it.

```py
# Write the SQL query to get the information you want
db_cursor.execute("""
SELECT
    s.id,
    s.name,
    s.hauler_id,
    h.id haulerId,
    h.name haulerName,
    h.dock_id
FROM Ship s
JOIN Hauler h
    ON h.id = s.hauler_id
""")
```

If you leave the rest of the code the way it is, you will get a response that looks like this.

```json
{
    "id": 1,
    "name": "Schmidt",
    "hauler_id": 1,
    "haulerId": 1,
    "haulerName": "CTS",
    "dock_id": 1
}
```

That certainly gets you all of the information needed about both the ship and the hauler, but it does not mimic the functionality of json-server. This means that you now need to custom-build the response by creating your own dictionaries.

1. Build a hauler dictionary with the correct keys and values
2. Build a ship dictionary that includes the hauler dictionary as a nested dictionary.
3. Then append your new `ship` dictionary to the list of ships.

```py
for row in query_results:
   hauler = {
       "id": row['haulerId'],
       "name": row['haulerName'],
       "dock_id": row["dock_id"]
   }
   ship = {
       "id": row['id'],
       "name": row['name'],
       "hauler_id": row["hauler_id"],
       "hauler": hauler
   }
   ships.append(ship)
```

That will generate a response with the proper format.

```json
{
   "id": 1,
   "name": "Schmidt",
   "hauler_id": 1,
   "hauler": {
      "id": 1,
      "name": "CTS",
      "dock_id": 1
   }
}
```

## Validate Logic

Now request expanded, and unexpanded ships, and verify that your get the correct JSON structure in the response for each.

Then, update the `retrieve_ship()` function appropriately to allow the client to request an expanded single ship.

## Next Steps

Once you expand the related resource of dock on the hauler, now you will embed all of the ships that are currently assigned to a hauler.

[Embed ships chapter >](./SS_API_IMPERATIVE_EMBED_HAULER_SHIPS.md)