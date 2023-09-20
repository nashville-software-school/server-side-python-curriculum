# Current Inventory

The team at **Elated Mane** wants to know what equipment they currently have in the organization, but separated by equipment type. Use `related_name` on the correct model in your API so that requests to `/equipmenttypes` return a response body that includes the current equipment for each type.

Feel free to override the default serialization of primary key if you would like the practice.

```json
[
    {
        "id": 1,
        "label": "Seating",
        "current_equipment": [
            2,
            8,
            10
        ]
    },
    {
        "id": 2,
        "label": "Styling",
        "current_equipment": [
            1,
            4,
            5
        ]
    },
    {
        "id": 3,
        "label": "Grooming",
        "current_equipment": [
            3,
            6,
            7,
            9
        ]
    }
]
```
