# Deleting Customers is Unsupported

As the developer of the API, you have complete control over what the client is allowed to do. It is driven largely by business rules, but other times it's driven by security measures that the team feels are necessary.

The product owner of the API has informed you that a client should be allowed to get all customers, get single customers, create new customers, and update customer information. However, customer information is the most valuable information for the Kennel business so that it can continue to send out marketing information.

Therefore, the client should not be allowed to delete customers.

## Research Guide

* What HTTP status can a server provide to inform the client that a certain HTTP method _(in this case, DELETE)_ is unsupported?
* Which method in `request_handler` should contain the logic to check if the client is trying to delete something that is not allowed?
* Also read [REST Response Code for DELETE Operation](https://medium.com/@sameira/rest-response-code-for-delete-operation-200-or-204-ee9c72a2dcb2) and make a decision about the correctness of your code in the `do_DELETE()` method.

<img src="./images/PK_DELETE_405.gif" alt="Animation showing an animal successfully deleted, but delete of customer unsupported" width="700px" />
