# Who's Using What?

The operations team at **Elated Mane** would like to know what equipment has been purchased for each stylist. Use `related_name` on the correct model in your API so that requests to `/stylists` return a response body that includes the the tools being used by each stylist.

Feel free to override the default serialization of primary key if you would like the practice.

```json
[
    {
        "id": 3,
        "first_name": "Meg",
        "last_name": "Ducharme",
        "email": "meg@ducharme.com",
        "username": "meg",
        "clients": [
            1,
            5
        ],
        "tools": [
            2,
            3,
            8,
            9
        ]
    },
    {
        "id": 4,
        "first_name": "Madi",
        "last_name": "Peper",
        "email": "madi@peper.com",
        "username": "madi",
        "clients": [
            3,
            4
        ],
        "tools": [
            1,
            4,
            7
        ]
    },
    {
        "id": 5,
        "first_name": "Ryan",
        "last_name": "Tanay",
        "email": "ryan@tanay.com",
        "username": "ryan",
        "clients": [
            2
        ],
        "tools": [
            5,
            6,
            10
        ]
    }
]
```
