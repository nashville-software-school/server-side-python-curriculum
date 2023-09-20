# Getting All Customers from the API

You will be creating a _View_ in this chapter. In Django, the _View_ handles the request from the client, does the work to get the requested data, and sends a response back to the client.

## Customer View

Inside the `views` folder create a file named `customer_view.py`. Here’s the view skeleton with the imports and methods we’ll add to next:

#### `honey-rae-server/repairsapi/views/customer_view.py`

```py
"""View module for handling requests for customer data"""
from django.http import HttpResponseServerError
from rest_framework.viewsets import ViewSet
from rest_framework.response import Response
from rest_framework import serializers, status
from repairsapi.models import Customer


class CustomerView(ViewSet):
    """Honey Rae API customers view"""

    def list(self, request):
        """Handle GET requests to get all customers

        Returns:
            Response -- JSON serialized list of customers
        """

        customers = Customer.objects.all()
        serialized = CustomerSerializer(customers, many=True)
        return Response(serialized.data, status=status.HTTP_200_OK)

    def retrieve(self, request, pk=None):
        """Handle GET requests for single customer

        Returns:
            Response -- JSON serialized customer record
        """

        customer = Customer.objects.get(pk=pk)
        serialized = CustomerSerializer(customer, context={'request': request})
        return Response(serialized.data, status=status.HTTP_200_OK)


class CustomerSerializer(serializers.ModelSerializer):
    """JSON serializer for customers"""
    class Meta:
        model = Customer
        fields = ('id', 'user', 'address')
```

## Add View to Package

#### `honey-rae-server/repairsapi/views/__init__.py`

```py
from .customer_view import CustomerView
```

## Adding the URL

So far we’ve set up the view and serializer but not which URL to use for the view. We need to add `/customers` to be supported by the API.

If a client sends a `GET` request to either `http://localhost:8000/customers` or `http://localhost:8000/customers/1`, we want the server to respond with the appropriate method.

You will use a built-in class in Django REST called the `DefaultRouter`. The `DefaultRouter` sets up the resource for each method that is present on the view.

> #### `honey-rae-server/honeyrae/urls.py`

Add the following import statements at the top of the `urls.py` module.

```py
from django.conf.urls import include
from rest_framework import routers
from repairsapi.views import CustomerView
```

In the same file, above the current `urlpatterns` variable, add the following:

```py
router = routers.DefaultRouter(trailing_slash=False)
router.register(r'customers', CustomerView, 'customer')
```
The `trailing_slash=False` tells the router to accept `/customers` instead of `/customers/`. It’s a very annoying error to come across, when your server is not responding and the code _looks_ right, the only issue is your fetch url is missing a `/` at the end.

The next line is what sets up the `/customers` resource. The first parameter, `r'customers`, is setting up the URL. The second `CustomerView` is telling the server which view to use when it sees that url.

The third, `customer`, is called the base name. You’ll only see the base name if you get an error in the server. It acts as a nickname for the resource and is usually the singular version of the URL.

Last step, once the `router` variable is set, we need to add it to the `urlpatterns`. Anywhere inside the `urlpatterns` list add the following line.

```py
path('', include(router.urls)),
```

## Test it out

Try it out in your API client!

1. Open the `tokens.json` file in your project and examine the `pk` key on each object. These are unique tokens assigned to every user in the system.
2. Copy any one of them to use in your API client.
3. Start a new request.
4. Add a new header to the request named `Authorization`
5. The value will be the word Token, followed by a space, and then the unique token you copied previously (e.g. `Token 0be249c88238743e5b4a7ac370b5145730c28e20`)
6. Then grab one of the following two URLs and generate a request.

`http://localhost:8000/customers` should return a list of all the customers.

`http://localhost:8000/customers/1` should return the customer with an id of 1.

## Examples

Here's how a request in Postman should look.

![](./images/postman-authorization-header.png)

Here's how a request in Insomnia should look.

![](./images/insomnia-authorization-header.png)
