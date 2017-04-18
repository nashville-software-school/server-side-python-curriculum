# Bangazon Orientation - Multiple Inheritance

## Instructions

Your job is to think about additional classes that can be inherited by certain groups of your other classes. For example, some employees may be part-time and others may be full-time. 

To avoid a long, brittle inheritance tree where you create a `PartTimeEmployee`, and a `FullTimeEmployee` that both inherit from `Employee`, and then having a `PartTimeHumanResourcesEmployee` and `FullTimeHumanResourcesEmployee` - ad naseum - break up the behaviors and properties that describe the different types.

```python
class FullTime():
  """Describes full-time employees"""
  
  def __init__(self):
    self.hours_per_week = 40
```

```python
class PartTime():
  """Describes part-time employees"""

  def __init__(self):
    self.hours_per_week = 24
```

```python
class HumanResources(Employee, FullTime):
  """Describes human resources employees"""

  def __init__(self, first_name, last_name):
    super().__init__(first_name, last_name) # super is Employee
    FullTime.__init__(self)
```

By breaking up your code this way, we've separated the inherent properties of an Employee from the properties that describe their employment status. Assume that there is a `Shipping` class that derives from `Employee` and those people work part time. However, a year from now, the company decides to make shipping people full-time employees.

Then the development team simply need to change the `PartTime` class to `FullTime` in the definition, and their weekly hours are changed.

Conversely, assume that there are currently 8 different classes that inherit from `PartTime`. The company changes the policy for part-time workers, bumping them from 24 hours/week to 28 hours/week.

One developer goes into the code and changes the value in the `PartTime` class and all inherited classes get the change immediately, while the `Employee` class remains unchanged.

## Suggestions for Changes

1. Consider separating the location of a department from its inherent properties. Perhaps one location needs an access card, while others don't. One may require people to check in with security and others don't.
1. Consider the possibility that some Employees may have a physical handicap that changes their working conditions. Some handicaps are temporary, and others may be added after the Employees is hired. You don't want those reflected in the base Employee inheritance chain, but in a separate chain altogether.
