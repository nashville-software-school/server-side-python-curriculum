# Expanded Order Response

Use the knowledge you gained in the Kennels Explorer chapter for finding the related information for an animal to augment your single order response to include the related metal, style, and size.

> Example Response for GET http://localhost:8088/orders/1

```json
{
    "id": 1,
    "timestamp": 1614659931693,
    "style": {
        "id": 3,
        "style": "Vintage",
        "price": 965
    },
    "metal": {
        "id": 3,
        "metal": "24K Gold",
        "price": 1258.9
    },
    "size": {
        "id": 2,
        "carets": 0.75,
        "price": 782
    }
}
```