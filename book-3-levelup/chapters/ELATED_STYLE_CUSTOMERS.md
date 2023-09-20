# Popular Styles

The stylists at **Elated Mane** would like to know which hair styles are currently the most popular to help their clients stay up to date with the latest trends. Use `related_name` on the correct model in your API so that requests to `/styles` return a response body that includes the clients who have that style.

Feel free to override the default serialization of primary key if you would like the practice.

```json
[
    {
        "id": 1,
        "label": "Pixie",
        "clients": [
            2,
            4
        ]
    },
    {
        "id": 2,
        "label": "Bob",
        "clients": [
            1,
            5
        ]
    },
    {
        "id": 3,
        "label": "Curly",
        "clients": [
            3
        ]
    }
]
```
