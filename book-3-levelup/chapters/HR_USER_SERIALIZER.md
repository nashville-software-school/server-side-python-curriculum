# Override User Serialization

The login form for the client you installed automatically enters in the credentials for Bryan Nilson, a customer who has submitted three service tickets to Honey Rae's Repairs. Go ahead and log in as him.

You will immediately be taken to the list of Bryan's tickets. The last one has been completed already, but it doesn't list the name of the employee who fixed it.

<img src="./images/completed_ticket.png" width="630px" alt="Image of completed ticket, but undefined employee name" />

This is because your API does not send back all of the information that the client needs to display that information. Watch the following video, and then implement the code yourself.

[![Honey Rae API - Serializing Ticket Employee Video](images/ticket_with_employee_video.png)](https://watch.screencastify.com/v/CJPF5fiVlqsZH8nxo892)


When you're done, you should see the name of the employee that is assigned to each of the three tickets.

<img src="./images/tickets_with_employees.png" width="630px" alt="Image of completed ticket, but undefined employee name" />