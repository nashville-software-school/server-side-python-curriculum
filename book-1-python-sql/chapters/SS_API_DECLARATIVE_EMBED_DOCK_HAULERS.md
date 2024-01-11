# Expanding Foreign Keys

In the imperative code project, you supported the use of the `_expand` query string parameter to show the details of the related hauler when the client requests a ship.

Now you need to do the same thing, but with haulers in this project. If the client requests and unexpanded hauler, the response should look like this.

GET http://localhost:8088/hauler/1

```json
{
    "id": 1,
    "name": "Algonquin",
    "dock_id": 2
}
```

If the client requests that the dock be expanded on the hauler, the response should look like this.

GET http://localhost:8088/hauler/1?_expand=hauler

```json
{
    "id": 1,
    "name": "Algonquin",
    "dock_id": 2,
    "dock": {
        "id": 2,
        "location": "Los Angeles",
        "capacity": 1800
    }
}
```

## Next Steps

Once the team expands the related resource of dock on the hauler, its time to support POST operations, but in a declarative style.

[Supporting POST chapter >](./SS_API_DECLARATIVE_POST.md)