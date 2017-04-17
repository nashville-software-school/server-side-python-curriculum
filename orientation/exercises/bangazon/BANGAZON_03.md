# Bangazon Orientation - Method Overloading

Method overloading in Python uses a single method, but utilizes parameter names and default values. This allows a single method to have multiple signatures.

## Instructions

1. Create a new class to represent an Employee.
1. It's constructor should accept two parameters.
    1. First name of employee
    1. Last name of employee
1. Define a method named `eat()` that will allow it to be invoked with the following four signatures.
    1. `eat()` - Will select a random restaurant name from a list of strings, print to console that the employee is at that restaurant, and also return the restaurant.
    1. `eat(food="sandwich")` - Will output that the employee ate that specific food at the office.
    1. `eat(companions=[Sam, Dean, Alice])` - Will select a random restaurant name from a list of strings, print to console that the employee is at that restaurant, and also output the first name of each employee in the specified list.
    1. `eat("pizza", [Sam, Dean, Alice])` - Will select a random restaurant name from a list of strings, print to console that the employee at that restaurant, and ordered the specified food, with the first name of the teammates specified in the list.
    
    
    * **Note**: Notice that this signature doesn't require that the parameters to be named


