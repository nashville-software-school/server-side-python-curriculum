# Filter Order by Resource

For this Explorer chapter, you will need to support the ability of a client to get orders that have a specific metal, style, or size with a query string parameter.

- GET http://localhost:8088/orders?metal=3
- GET http://localhost:8088/orders?size=1
- GET http://localhost:8088/orders?style=2

Each of those requests should only return orders that have a matching value in the corresponding foreign key.

For example, if only one order has a `metal_id` value of 3, the response body should be an array with one object in it. If three orders have a `style_id` value of 2, then the response body should have an array with three objects in it.