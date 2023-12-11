# Kneel Diamonds Feature Requirements

## Your Style

Now you get to make the decision about how to you want build this project - imperatively, declaratively, or a mixture of the two. Bring over any code from either of the Shipping Ship API projects that you want.

Here are all of the requirements for your API, broken down by resource.

## Orders

| Method | Endpoint | Response Body | Status Code |
|--|--|--|--|
| POST | /orders | New order object | 201 |
| GET | /orders | Array of all order objects | 200 |
| GET | /orders/_n_ | Single order object | 200 |
| DELETE | /orders/_n_ | Cancel an order | 204 |
| PUT | /orders/_n_ | Rejection message | 405 |

## Sizes

| Method | Endpoint | Response Body | Status Code |
|--|--|--|--|
| GET | /sizes | Array of all size objects | 200 |
| GET | /sizes/_n_ | Single size object | 200 |
| POST | /sizes | Rejection message | 405 |
| PUT | /sizes | Rejection message | 405 |
| DELETE | /sizes/_n_ | Rejection message | 405 |

## Styles

| Method | Endpoint | Response Body | Status Code |
|--|--|--|--|
| GET | /styles | Array of all style objects | 200 |
| GET | /styles/_n_ | Single style object | 200 |
| POST | /styles | Rejection message | 405 |
| PUT | /styles | Rejection message | 405 |
| DELETE | /styles/_n_ | Rejection message | 405 |

## Metals

| Method | Endpoint | Response Body | Status Code |
|--|--|--|--|
| GET | /metals | Array of all metal objects | 200 |
| GET | /metals/_n_ | Single metal object | 200 |
| POST | /metals | Rejection message | 405 |
| PUT | /metals | Rejection message | 405 |
| DELETE | /metals/_n_ | Rejection message | 405 |

## Support Expanding Orders

Once you implement all of the basic CRUD operations, you need to support expanding any of the related resources on an order.

GET http://localhost:8000/orders/1?_expand=metal

```json
{
    "id": 1,
    "metal_id": 3,
    "style_id": 1,
    "size_id": 2,
    "metal": {
        "id": 3,
        "metal": "24K Gold",
        "price": 1258.9
    }
}
```

GET http://localhost:8000/orders/1?_expand=size

```json
{
    "id": 1,
    "metal_id": 3,
    "style_id": 1,
    "size_id": 2,
    "size": {
        "id": 2,
        "carets": 0.75,
        "price": 782
    }
}
```

GET http://localhost:8000/orders/1?_expand=size&_expand=style

```json
{
    "id": 1,
    "metal_id": 3,
    "style_id": 1,
    "size_id": 2,
    "size": {
        "id": 2,
        "carets": 0.75,
        "price": 782
    },
    "style": {
        "id": 1,
        "style": "Vintage",
        "price": 965
    }
}
```
