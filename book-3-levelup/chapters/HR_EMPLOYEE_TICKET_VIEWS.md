# Expose All Data

Repeat the entire process from the last chapter to expose the data for employees and tickets.

By the end you should have an `EmployeeView` and `TicketView` with the `list` and `retrieve` methods added. Each view should also have it’s own serializer. When you get to the `urls.py` you’ll only need to add the `router.register` calls to add the `/employees` and `/serviceTickets` resources.

| Method | URL | Response Data |
|--|--|--|
|GET | http://localhost:8000/employees | List of all employees |
|GET | http://localhost:8000/employees/2 | The second employee |
|GET | http://localhost:8000/serviceTickets | List of all tickets |
|GET | http://localhost:8000/serviceTickets/4 | The fourrth ticket |