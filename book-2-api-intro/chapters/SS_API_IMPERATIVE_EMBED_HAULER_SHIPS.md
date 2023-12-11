# Supporting Embed

Remember that json-server allowed you to embed all related resources? It was the reverse of expand?

For example, if you wanted to see all of the ships that a hauler was carrying, you could use the `_embed` query string parameter.

GET http://localhost:8000/hauler/1

```json
{
    "id": 1,
    "name": "Albatross",
    "dock_id": 3
}
```

GET http://localhost:8000/hauler/1?_embed=ships

```json
{
    "id": 1,
    "name": "Albatross",
    "dock_id": 3,
    "ships": [
        {
            "id": 2,
            "name": "Joquin",
            "hauler_id": 1
        },
        {
            "id": 5,
            "name": "Prince Henry",
            "hauler_id": 1
        }
    ]
}
```

See if you can figure out how to, in the `list_haulers()` build up a list of related ships for a hauler when that query string parameter is present.

