# Expose All Data

Repeat the entire process from the last chapter to expose the data for employees and tickets.

By the end you should have an `EmployeeView` and `TicketView` with the `list` and `retrieve` methods added. Each view should also have it’s own serializer. When you get to the `urls.py` you’ll only need to add the `router.register` calls to add the `/employees` and `/serviceTickets` resources.

Use your API client to make the following requests and verify that you get a proper response.

| Method | URL | Response Data |
|--|--|--|
| GET | http://localhost:8000/employees | List of all employees |
| GET | http://localhost:8000/employees/2 | The second employee |
| GET | http://localhost:8000/serviceTickets | List of all tickets |
| GET | http://localhost:8000/serviceTickets/4 | The fourth ticket |

## Expanding Ticket Data The Easy Way

Once you have the initial view and serializer class for a service ticket, update the serializer to automatically expand any foreign keys - in this case, employee and customer - during the serialization to JSON.

## Ticket View

When you create your service ticket view, instead of just having `ServiceTicket.objects.all()` in the `list()` method, you will need to take account of the fact that sometimes customers will be requesting their own tickets, and employees can view all tickets.

Use the following code in to handle that situation.

```py
if request.auth.user.is_staff:
    service_tickets = ServiceTicket.objects.all()
else:
    service_tickets = ServiceTicket.objects.filter(customer__user=request.auth.user)
```

## Serialization of Ticket

Currently, if you request ticket 7, the JSON serialized response looks like this. The employee and customer properties just have the integer foreign key value.

```json
{
	"id": 7,
	"description": "Aut qui possimus quisquam quibusdam illo in provident. Et repellendus reprehenderit quidem reiciendis deleniti doloribus.",
	"emergency": true,
	"date_completed": null,
	"employee": 2,
	"customer": 3
}
```

Adding the `depth = 1` instruction on the Meta class makes Django do the magic of expansion.

```py
    class Meta:
        model = ServiceTicket
        fields = ( 'id', 'description', 'emergency', 'date_completed', 'employee', 'customer', )
        depth = 1
```

Request ticket 7 again, and the JSON now looks like this.

```json
{
	"id": 7,
	"description": "Aut qui possimus quisquam quibusdam illo in provident. Et repellendus reprehenderit quidem reiciendis deleniti doloribus.",
	"emergency": true,
	"date_completed": null,
	"employee": {
		"id": 2,
		"specialty": "Laptops",
		"user": 5
	},
	"customer": {
		"id": 3,
		"address": "401 Unauthorized Ct.",
		"user": 4
	}
}
```
