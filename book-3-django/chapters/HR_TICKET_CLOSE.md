# Closing a Ticket

In this Explorer chapter, you are going to allow an employee to close (finish) a ticket.

1. Add a button to the ticket details view labeled "Mark Done" that only appears for employees.
2. When clicked, the client should perform a PUT operation to the server. The body of the request should have the `date_completed` property of the ticket set to the current date. Make sure it is in the format that Django wants _(i.e. `Date.now()` is not sufficient)_.
   ```txt
   YYYY-MM-DD
   ```
3. In the API, make sure the `update()` method of the ticket view updates the `date_completed` property of the specified ticket and saves it.

