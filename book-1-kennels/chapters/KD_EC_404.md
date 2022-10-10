# Inventory Not Available

When the API client performs a GET requests for an invalid size, style, order, or metal, make sure that the client gets sent a 404 status code with a message in the response body that indicates that it is not in the inventory.

#### Example for invalid metal

```py
{
    "message": "That metal is not currently in stock for jewelry."
}
```

When the client requests an invalid order, respond with the following message and ensure it has a 404 status code.

#### Example for invalid order

```py
{
    "message": "That order was never placed, or was cancelled."
}
```
