# Finding Tickets

Eventually, there will be many tickets in the system, and employees will want the ability to find certain tickets instead of scrolling through all of them in the browser.

1. Add a text input field above the list of tickets that only employees can see.
2. When the user types into that field, the client should send a GET request to the API. The request should have a query string parameter _(you get to choose the parameter name)_ whose value is what the user has typed into the field.
3. The API should check if that query string parameter is in the request.
4. If it is, use the ORM to check if the description property of a ticket [contains the characters](https://medium.com/codeptivesolutions/https-medium-com-codeptivesolutions-commonly-used-sql-queries-using-django-orm-e8466e8d4258#5eb2) that the employee provided.

