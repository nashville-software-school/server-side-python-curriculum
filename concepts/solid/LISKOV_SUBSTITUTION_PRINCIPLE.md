# Liskov Substitution Principle

## Definition

> Let &#966;(&#967;) be a property provable about objects &#967; of type T. Then &#966;(&#933;) should be true for objects &#933; of type S where S is a subtype of T.

#### In Programmer Language
Functions that use references to base classes must be able to use objects of the derived class with no runtime side effects.

#### In Beginner Language
Derived classes must be substitutable for the base class without any impact on the expected functionality of the system.

## Object Behavior Implications
This principle makes clear that in object-oriented design the _IsA_ relationship pertains to behavior. Not intrinsic private behavior, but extrinsic public behavior; behavior that clients depend upon. This means that if two classes share the exact same properties and methods, that does not ensure that one is inheritable from the other.

## Example

Let's say you're building an application that displays products for people to buy. In order to represent those products, as a responsible developer, you create a class definition which defines the properties and behaviors of a product.

```py
class Product(object):

    def __init__(self):
        pass

    @property
    def price(self):
        try:
            return self.__price
        except AttributeError:
            return 0

    @price.setter
    def price(self, price):
        if price > 0:
            self.__price = price
        else:
            self.__price = 0.01

    @property
    def title(self):
        try:
            return self.__title
        except AttributeError:
            return ""

    @title.setter
    def title(self, title):
        if len(title) > 0:
            self.__title = title
        else:
            raise ValueError('You must provide a string value for the title property')

    @property
    def description(self):
        try:
            return self.__description
        except AttributeError:
            return ""

    @description.setter
    def description(self, description):
        if len(description) > 0:
            self.__description = description
        else:
            raise ValueError('You must provide a string value for the description property')
```

As the system evolves, the feature of a bulk product is introduced. So another developer defines a class named `BulkProduct` that derives from `Product` because it makes sense that a `BulkProduct` _IsA_ `Product`, just a more specialized kind.

```py
class BulkProduct(Product):

    def __init__(self):
        pass

    @property
    def price(self):
        try:
            return self.__price
        except AttributeError:
            return 0

    @price.setter
    def price(self, price, quantity):
        self.__price = price * quantity
```

Elsewhere in the system, we have a function that allows for the creation of a product.

```py
def create_product(request):
    data = request.POST

    new_product = Product(
                          price=data["price"], 
                          title=data["title"]
    )
    new_product.save()
```

If we substitute `BulkProduct` into the code instead of `Product` we will get an **AttributeError** raised because the `quantity` property is not set.


The author of the `Product` class intended for the `price` property to be self-contained and independent of any other variable. The `BulkProduct` class violates the LSP because it intends that the `price` property is now dependent upon the `quantity` property.

Therefore, the conclusion is that the relationship between a `Product` and a `BulkProduct` is not an _IsA_ relationship at all.

In this case, composition (a _PartOf_ relationship), would be more appropriate.

```py
from product import Product

class BulkProduct():

    def __init__(self):
        pass

    @property
    def price(self):
        try:
            return self.__price
        except AttributeError:
            return 0

    @property
    def quantity(self):
        try:
            return self.__quantity
        except AttributeError:
            return 0

    @quantity.setter
    def quantity(self, quantity):
        self.__quantity = quantity
        self.__price = self.product.price * quantity

    @property
    def product(self):
        try:
            return self.__product
        except AttributeError:
            return None

    @product.setter
    def product(self, product):
        if type(product) is Product:
            self.__product = product
        else:
            raise ValueError('You must provide a product instance')
```

#### Example implementation code

```py
from product import Product
from bulkproduct import BulkProduct

# Create a product instance
marble = Product()
marble.price = 0.08

# Compose product into a bulk product instance
bag_of_marbles = BulkProduct()
bag_of_marbles.product = marble
bag_of_marbles.quantity = 200
print("Bulk price: " + str(bag_of_marbles.price))
```
