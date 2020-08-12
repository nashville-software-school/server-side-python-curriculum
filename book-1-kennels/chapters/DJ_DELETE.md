# Deleting Entries

## Server

1. Create a `delete_entry()` function in the request module of your entries package.
1. Make sure the function accepts the `id` of the entry to be deleted.
1. Write your `DELETE FROM` SQL statement, with a parameter, to remove the item from the database.

## Client

Click the delete button on one of your entries from your Daily Journal client. Verify that the entry gets deleted from the database and that the client renders the new state of the entries collection.
