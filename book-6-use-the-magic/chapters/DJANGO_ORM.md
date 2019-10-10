# Using the Django ORM

## Filtering Querysets

Suppose you want to see all of the products that were created by a particular user.

```py
current_user = Customer.objects.get(user=request.auth.user)
Product.objects.filter(customer=current_user)
```

Or perhaps you want a list of all products that are being sold in a particular city.

```py
# Example GET request:
#   http://localhost:8000/products?location=louisville
products = Product.objects.all()

location = self.request.query_params.get('location', None)

if location is not None:
    products = products.filter(location__contains=location)
```

Want to get the most recent _n_ products entered into the system?

```py
# Example request:
#   http://localhost:8000/products?quantity=20
products = Product.objects.all()

quantity = self.request.query_params.get('quantity', None)

if quantity is not None:
    products = products.order_by("-created_date")[:int(quantity)]

```

Perhaps the user wants to see all the products in a particular category.

```py
# Example request:
#   http://localhost:8000/products?category=3
products = Product.objects.all()

category = self.request.query_params.get('category', None)

if category is not None:
    products = products.filter(product_category__id=category)
```

## Custom Actions on a ViewSet

If the customer has an open order with some products on it and you want to return them to the client. You can create a custom route to view the current user's shopping cart.

Make sure you use `related_name` in your **`OrderProduct`** model.

```py
from django.db import models
from .order import Order
from .product import Product

class OrderProduct(models.Model):

    order = models.ForeignKey(Order, on_delete=models.DO_NOTHING, related_name="cart")
    product = models.ForeignKey(Product, on_delete=models.DO_NOTHING, related_name="cart")
```

Then create a new route named `orders/cart` and perform the following logic.

1. Determine if there is an order created for the authenticated customer.
1. If there isn't, return a 404.
1. If there is, get all products in a relationship with that order.
1. Serialize the products by importing the `ProductSerializer` from the `views/product.py` module.

```py
# Example request:
#   http://localhost:8000/orders/cart
@action(methods=['get'], detail=False)
def cart(self, request):
    current_user = Customer.objects.get(user=request.auth.user)

    try:
        open_order = Order.objects.get(customer=current_user, payment_type=None)
        products_on_order = Product.objects.filter(cart__order=open_order)
    except Order.DoesNotExist as ex:
        return Response({'message': ex.args[0]}, status=status.HTTP_404_NOT_FOUND)

    serializer = ProductSerializer(products_on_order, many=True, context={'request': request})
    return Response(serializer.data)
```
