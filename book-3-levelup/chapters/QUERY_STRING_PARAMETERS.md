# Using Query String Parameters in API Requests

## Accessing Parameters

All query string parameters in a request URI are gathered by Django into the `request.query_params` namespace. You can extract individual query params using the `get()` method.

If you submit the following request.

```
http://localhost:8000/products?category=3&quantity=5&order_by=created_date&direction=desc
```

You could extract each of the four parameters with the code below.

```py
category = self.request.query_params.get('category', None) # 3
quantity = self.request.query_params.get('quantity', None) # 5
order = self.request.query_params.get('order_by', None) # 'created_date'
direction = self.request.query_params.get('direction', None) # 'desc'
```

## Using the Parameters

You can then use those parameters to customize the response back to the client. Here's how you would handle using the `order_by` and `direction` parameters to let the client order the items in the response by any column, either ascending or descending.

```py
# Example request:
#   http://localhost:8000/products?order_by=price&direction=desc
products = Product.objects.all()

if order is not None:
    filter = order

    if direction is not None:
        if direction == "desc":
            filter = f'-{filter}'

    products = products.order_by(filter)
```