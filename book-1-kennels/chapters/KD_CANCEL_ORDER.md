# Cancel an Order

Back when you first built Kneel Diamonds client, you didn't implement the ability to delete an existing order from the database. Now that you are learning about the basics of server-side code, you will provide that ability to the client.

## Delete Method

Add a `delete_order` function to the appropriate module. Then copy pasta the code from one of the Kennels modules and update it to work with the data in this project.

Import the function into the views package, and then import from the views package into the `request_handler` module.

## Delete Handling

Now update the `do_DELETE` method in `request_handler` from stolen code from Kennels and update it to check for the correct URL resource.

Submit a DELETE request to the proper URL. For example, if you want to delete the 5th order, use this information

| Method | URL |
|--|--|
| DELETE | http://localhost:8088/orders/5 |

If you want to delete the 88th order...

| Method | URL |
|--|--|
| DELETE | http://localhost:8088/orders/88 |

To verify that is works, immediately GET all orders and check that the one you deleted is no longer in the list.

<img src="./images/KD_DELETE_ORDERS.gif" width="700px" alt="Animation showing the DELETE request and response" />


