# Expose All Data

Repeat the entire process from the last chapter to support GET requests for employees and tickets.

By the end you should have an `EmployeeView` and `TicketView` with the `list` and `retrieve` methods added. Each view should also have it’s own serializer. When you get to the `urls.py` you’ll only need to add the `router.register` calls to add the `/employees` and `/serviceTickets` resources.

Use your API client to make the following requests and verify that you get a proper response.

| Method | URL | Response Data |
|--|--|--|
| GET | http://localhost:8000/employees | List of all employees |
| GET | http://localhost:8000/employees/2 | The second employee |
| GET | http://localhost:8000/serviceTickets | List of all tickets |
| GET | http://localhost:8000/serviceTickets/4 | The fourth ticket |

## Expanding Ticket Data

Once you have the initial view and serializer class for a service ticket, update the current serializer and add a new sub-serializer to automatically expand any foreign keys - in this case, **employee** and **customer** - during the serialization to JSON.

Your response should now look like this for a single ticket that has been assigned to an employee.

```json
{
	"id": 1,
	"description": "Alias ullam et tempora architecto qui exercitationem est eius.",
	"customer": {
		"id": 6,
		"address": "87819 Roob Fall",
		"user": 6
	},
	"employee": {
		"id": 3,
		"specialty": "vel non ab",
		"user": 3
	}
}
```

Your response should now look like this for a single ticket that has been assigned to an employee.

```json
{
	"id": 1,
	"description": "Alias ullam et tempora architecto qui exercitationem est eius.",
	"customer": {
		"id": 6,
		"address": "87819 Roob Fall",
		"user": 6
	},
	"employee": {
		"id": 3,
		"specialty": "vel non ab",
		"user": 3
	}
}
```

> 🧨 What do you need to add to your module to also expand the `user` property to include the customer's or employee's first and last name?

## Ticket View

Open your existing ticket view.

Instead of just having `ServiceTicket.objects.all()` in the `list()` method, you will need to take account of the fact that sometimes customers will be requesting their own tickets, and employees can view all tickets.

Use the following code in to handle that situation.

```py
if request.auth.user.is_staff:
    service_tickets = ServiceTicket.objects.all()
else:
    service_tickets = ServiceTicket.objects.filter(customer__user=request.auth.user)
```

In the world of Django ORM, that double underscore between customer and user

```txt
customer__user
```

Is actually a JOIN in SQL. It allows your to traverse the foreign key relationships that are defined in the model. In this case, the following line of code...

```py
service_tickets = ServiceTicket.objects.filter(customer__user=request.auth.user)
```

Can be explained in English like this...

> Start in the service ticket table and access the `customer` property to go to the Customer table, then access the `user` property to go to the User table. Filter the service tickets where the authenticated user is assigned to the ticket.

And expressed in SQL like this...

```sql
SELECT
	t.description,
	t.date_completed,
	t.customer_id,
	t.employee_id,
	t.emergency
FROM repairsapi.serviceticket t
JOIN repairsapi.customer c ON
	t.customer_id = c.id
JOIN auth.user u ON
	c.user_id = u.id
WHERE
	u.id = {request.auth.user.id}
```
