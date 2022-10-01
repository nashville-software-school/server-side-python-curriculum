# Inventory Not Available

When the API client requests an invalid size, style, or metal, make sure that the client gets sent a 404 status code with a message in the response body that indicates that it is not in the inventory.

#### Example

```py
{
    "message": "Rhodium is not a metal kept in stock for jewelry."
}
```

When the client requests an invalid order, respond with the following message and ensure it has a 404 status code.

#### Example

```py
{
    "message": "That order was never placed, or was cancelled."
}
```
