# Inheritance, Composition, and Aggregation

## Inheritance

Inheritance is for straightforward is-a relationship.

A baseball is a ball.

A skyscaper is a building.

```python
class Ball:
    def __init__(self):
        self.radius = 0
        self.weight = 0

class Baseball(Ball):
    def __init__(self):
        self.stitches = 0

class SoccerBall(Ball):
    def __init__(self):
        self.panels = 0
```

## Composition

Composition is for things that make up other things. If the container object is destroyed, so will all of its composing parts. Composition is the pattern for part-of relationships.

A pancreas is part of a body.

A room is part of a building.

```python
class Pancreas:
    def __init__(self):
        self.filtering = True

class Liver:
    def __init__(self):
        self.poisoned = False

class Body:
    def __init__(self):
        self.the_pancreas = Pancreas()
        self.the_liver = Liver()
```

## Aggregation

Aggregation is for adding objects that are needed for the operation of another object, but should exist independently of it should it be destroyed. Aggregation is the pattern for has-a relationships.

```python
class Customer:
    def __init__(self, fn, ln, acct):
        self.accountNumber = acct
        self.firstName = fn
        self.lastName = ln


class Bank:
    def __init__(self):
        self.name = ""
        self.address = ""
        self.lastName = ""

        self.customers = set()

if __name__ == '__main__':
    # Create the bank
    FirstTennessee = Bank()

    # Create some customers
    steve = Customer("Steve", "Brownlee", "000000000")
    ryan = Customer("Ryan", "Tanay", "000000000")
    charisse = Customer("Charisse", "Lambert", "000000000")

    # Add the customers into the aggregate instance variable of the bank
    FirstTennessee.customers.add(steve)
    FirstTennessee.customers.add(ryan)
    FirstTennessee.customers.add(charisse)

```

In this last example, the Customer you created would not cease to exist should the Bank in which it had an account went bankrupt and closed.





