# Sort Animals by Status

Update your logic for getting all animals to allow the client to sort by animal name.

GET http://localhost:8088/animals?_sortBy=name

The response list should by sorted by the `name` property in ascending order. This one is trickier because the `Animal` table is not the only one with a `name` field.
