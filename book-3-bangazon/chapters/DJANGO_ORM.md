# Using the Django ORM
Up to this point, you've interacted with your databases via SQl, using queries like
```sql
SELECT employee.first_name, employee.last_name, employee.department
FROM employees
WHERE employee.id = 2
```

But one of the powerful features of a framework like Django is its ability to streamline and abstract the process of interacting with your data. And you have already worked with the key the unlocking this streamlined process: Django Models.

Once you’ve created your data models, Django automatically gives you a database-abstraction API that lets you create, retrieve, update and delete objects. That abstraction is referred to as an ORM -- Object Relational Mapper. Object relational mapping allows you to write queries like the one above, as well as much more complicated ones, using classes and methods. So, fetching that employee would look like this instead:

```py
   ①       ②       ③
Employee.objects.get(pk=2)
```

① we are referencing the `Employee` model directly, not the employees table.  
② `objects` refers to all of the instances of the Employee model in the db.  
③ That `objects` object has a method named `get` that returns an object to us that represents the record with an id (or pk, for primary key) of 2.

## The Django ORM in Action
Let's look at using the Django ORM to create, read, update, and destroy a record in our db, using the following model

```py
class Product(models.Model):

    title = models.CharField(max_length=200)
    description = models.CharField(max_length=500)
    price = models.DecimalField(max_digits=20, decimal_places=2)
    quantity = models.IntegerField(default=1)
    location = models.CharField(max_length=50)
    created_date = models.DateTimeField(auto_now_add=True)
    seller = models.ForeignKey("User", on_delete = models.CASCADE)
    product_category = models.ForeignKey("ProductCategory", on_delete=models.Cascade)
```

1. Creating a new instance and saving it to the db can be done a couple of ways.
```py

# Gotta supply an instance of a User as the foreign key
current_user = Customer.objects.get(user=request.auth.user)
product_cat

# instantiate...
new_prod = Product(
    title = "wonder widget",
    description = "The greatest thing since sliced bread",
    price = 99.99,
    quantity = 125,
    location = "Nashville",
    seller = current_user,
    product_category_id = 3
)

# and then save to the db
new_prod.save()

# Or...
# Use a shortcut to do both at the same time
new_prod = Product.objects.create(
    title = "wonder widget",
    description = "The greatest thing since sliced bread",
    price = 99.99,
    quantity = 125,
    location = "Nashville",
    seller = current_user,
    product_category_id = 3
)
```
2. Retrieving
```py
# find one, by its id
prod = Product.objects.get(pk=1)

# find all
products = Product.objects.all()
```
3. Updating
```py
# retrieve it first:
prod = Product.objects.get(pk=1)

# Reassign a property's value
prod.price = 75.50

# Save the change to the db
prod.save()

```
4. Deleting
```py
# need to retrieve the object, then delete it. This is a safety measure that keeps up from deleting a whole collection accidentaly
prod = Product.objects.get(pk=1)
prod.delete()
```

## Working With Querysets
Above, we referenced `Product.objects` in each query. Calling `Foo.objects.<some method()>` results in what Django calls a queryset. A queryset is simply a collection of objects from your database.


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

What you have to do next is create a custom action on the ViewSet. This action's name actually defines a brand new route, for you without any more action on your part.

So, for example, the action below is named `cart`. It is on the product ViewSet. Therefore, your app will now respond to any request to `http://localhost:8000/product/cart`.

This is the logic of getting the products on the current user's cart.

1. Determine if there is an order created for the authenticated customer.
1. If there isn't, return a 404.
1. If there is, get all products in a relationship with that order.
1. Serialize the products by importing the `ProductSerializer` from the `views/product.py` module.

```py
from rest_framework.decorators import action

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

## Reference
[Django querysets](https://docs.djangoproject.com/en/3.0/ref/models/querysets/#queryset-api)
[Making Queries](https://docs.djangoproject.com/en/3.0/topics/db/queries/)
