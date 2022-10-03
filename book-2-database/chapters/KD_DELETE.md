# Deleting Order

## Handling DELETE Requests

1. Rewrite the `delete_order()` function to use SQL, with a parameter, to delete a single record from the **Orders** table.
1. Restart your debugger.
1. DELETE http://localhost:8088/orders/2
1. GET http://localhost:8088/orders
1. Verify that you get the correct JSON representation of your orders and that the one you deleted is no longer in the database.

