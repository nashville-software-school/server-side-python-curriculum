# Interface Segregation Principle

> Clients should not be forced to depend upon interfaces that they do not use. When a client depends upon a class that contains interfaces that the client does not use, but that other clients do use, then that client will be affected by the changes that those other clients force upon the class.

This principle is strongly related to the [Single Responsiblity Principle](./SINGLE_RESPONSIBILITY_PRINCIPLE.md), in that deals with ensuring that your system interfaces start small and deal with only one facet of the responsibilities of your system.

## Interface-based Programming

> **Pro tip:** This is an advanced topic that requires, often, years of practical usage before it *clicks* with a developer. This is a primer, and feeling like it goes over your head is normal.

Interfaces specify the properties and methods that a derived class **must** implement. The interface itself doesn't provide any guidance on *how* they must be implemented - simply that they must.

Python doesn't have interfaces by name, but it does implement the concept with [Abstract Base Classes](https://docs.python.org/3.5/library/abc.html). An ABC defines a contract that implementing classes agree to implement. That's what an interface is.

* Classes define a blueprint for an object.
* Interfaces (ABCs) define an implementation contract for classes.

#### Transaction Interface

In this sample interface, the properties and methods of a transaction are defined. You'll note that there are no implementation details at all. What is enforces is that any specific kind of transaction we define in our system that derives from this interface must implement these methods and properties.

```py
from abc import ABCMeta, abstractmethod


class Transaction(metaclass=ABCMeta):

    @property
    def amount(self):pass

    @amount.setter
    @abstractmethod
    def amount(self, val):pass

    @property
    def account(self):pass

    @account.setter
    @abstractmethod
    def account(self, val):pass

    @property
    def customer(self):pass

    @customer.setter
    @abstractmethod
    def customer(self, val):pass

    @abstractmethod
    def adjust_account(self):pass

    @abstractmethod
    def add_to_inventory(self, product):pass

    @abstractmethod
    def remove_from_inventory(self, product):pass

    @abstractmethod
    def depreciate(self, product):pass

    @abstractmethod
    def amortize(self, product):pass

    @property
    def vendor(self):pass

    @vendor.setter
    @abstractmethod
    def vendor(self, val):pass

    @abstractmethod
    def capital_expense(self, product):pass
```

This is a comprehensive list of properties and methods for transactions in our system, but it violates the Interface Segregation Principle.

Here's why.

One type of transaction in our system is a `Refund`. This is when a customer wants to get a refund for a defective product. Our service policy does not require the customer to return the defective product if there is evidence that it is defective.

You'll see a definition of the properties and methods needed for this type of transaction.

* The customer
* The amount of the transaction
* The company account that needs to be adjusted.

```py
class Refund(Transaction):

    @property
    def amount(self):
        return self.__amount

    @amount.setter
    def amount(self, val):
        self.__amount = val

    @property
    def account(self):
        return self.__account

    @account.setter
    def account(self, val):
        self.__account = val

    @property
    def customer(self):
        return self.__customer

    @customer.setter
    def customer(self, val):
        self.__customer = val

    def adjust_account(self):
        self.__account.balance += self.__amount
```

However, because it derives from the `Transaction` interface, you would not be allowed to create an instance of `Refund` because it does not implement the other properties and methods.

```
refund = Refund()
TypeError: Can't instantiate abstract class Refund with abstract methods add_to_inventory, amortize, capital_expense, depreciate, remove_from_inventory, vendor
```

So rather than having a fat interface that handles the description of every possible type of transaction, we would need to define more specific types of interfaces that related transactions could use.

```py
from abc import ABCMeta, abstractmethod


class CustomerTransaction(metaclass=ABCMeta):
    '''This interface defines properties and methods required by
    a transaction that requires customer information'''

    @property
    def amount(self):pass

    @amount.setter
    @abstractmethod
    def amount(self, val):pass

    @property
    def customer(self):pass

    @customer.setter
    @abstractmethod
    def customer(self, val):pass


class AccountingTransaction(metaclass=ABCMeta):
    '''This interface defines properties and methods required by
    a transaction that requires an entry in the accounting system'''

    @property
    def amount(self):pass

    @amount.setter
    @abstractmethod
    def amount(self, val):pass

    @property
    def account(self):pass

    @account.setter
    @abstractmethod
    def account(self, val):pass

    @abstractmethod
    def adjust_account(self):pass

```

Now the `Refund` class would inherit from those interfaces because they are the only ones that it relies on.

```py
class Refund(CustomerTransaction, AccountingTransaction):

    @property
    def amount(self):
        return self.__amount

    @amount.setter
    def amount(self, val):
        self.__amount = val

    @property
    def account(self):
        return self.__account

    @account.setter
    def account(self, val):
        self.__account = val

    @property
    def customer(self):
        return self.__customer

    @customer.setter
    def customer(self, val):
        self.__customer = val

    def adjust_account(self):
        self.__account.balance += self.__amount
```

# References

* [Why use abstract classes in Python](http://stackoverflow.com/questions/3570796/why-use-abstract-base-classes-in-python)
* [Develop to interfaces, not implementations](http://stackoverflow.com/questions/2697783/what-does-program-to-interfaces-not-implementations-mean)