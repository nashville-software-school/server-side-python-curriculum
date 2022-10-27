# Done Or Not Done

In this chapter, you are going to update the `list()` method in the service ticket view of your API to check for the existence of query parameters. Specifically, the `status` query parameters.

In the client, you will notice two buttons at the top of the service ticket list when you are authenticated as an employee.

* Show Done
* Show All

When either of those buttons are clicked, a new request is sent to the API with either "done" or "all" set as the value of the "status" query string parameter.

```js
const filterTickets = (status) => {
    fetchIt(`http://localhost:8000/tickets?status=${status}`)
        .then((tickets) => {
            setOriginal(tickets)
        })
        .catch(() => setOriginal([]))
}
```

A quick refresher on the breakdown of the request.

| Method | URL | Query Param |
| --| --|--|
| GET | http://localhost:8000/tickets?status=done | status=done |

Now the API code has to be a bit smarter. In Django, the `request` object automatically has a property on it called `query_params`. It is a dictionary with the keys and values of all query params in the URL. In this case, the dictionary will look like this.

```py
{
    "query_params": {
        "status": "done"
    }
}
```

## Updated List Method

Next, update the `list()` method in the ticket view to...

1. Check if there is a query string parameter
   1. If there is, and its value is "done", use the ORM to query the database for only those ticket that have a completion date.
   2. If there is, and its value is "all", use the ORM to query the database for all tickets.
2. If there is no query string parameter, return all tickets.


```py
service_tickets = []

if "status" in request.query_params:
    if request.query_params['status'] == "done":
        service_tickets = ServiceTicket.objects.filter(date_completed__isnull=False)

    if request.query_params['status'] == "all":
        service_tickets = ServiceTicket.objects.all()

else:
    service_tickets = ServiceTicket.objects.all()


serialized = ServiceTicketSerializer(service_tickets, many=True)
return Response(serialized.data, status=status.HTTP_200_OK)
```