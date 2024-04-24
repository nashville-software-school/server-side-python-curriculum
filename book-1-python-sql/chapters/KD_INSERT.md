# Creating a New Order

When your client performs a POST operation to http://localhost:8088/orders with a JSON representation of an order object in the body, your server should handle the request and invoke a `create_order()` function.

The creation function should contain the `INSERT INTO` SQL statement to get the information stored in the `Orders` table.