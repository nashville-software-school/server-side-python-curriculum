# Bangazon Orientation - Defining Your Departments

## Setup

```bash
mkdir -p workspace/python/orientation/bangazon && cd $_
touch bangazon.py
```

## Instructions

1. Create a *Department* class. Create some simple properties and methods on Department. You are going to create some derived classes that inherit from Department, so make sure that the properties/methods you add are general to **all** Departments (e.g. name, supervisor, employee_count, etc).

  ##### Example property/method definition

    ```python

    class Department(object):
      """Parent class for all departments"""

      def __init__(self):
          self.employees = set()

      @property
      def name(self):
        try:
          return self.__name
        except AttributeError:
          return ""

      @name.setter
      def name(self, val):
        if isinstance(val, str):
          raise TypeError('Please provide a string value for the department name')

        if val is not "" and len(val) > 1:
          self.__name = val
        else:
          raise ValueError("Please provide a department name")

      @property
      def supervisor(self):

        try:
          return self.__supervisor
        except AttributeError:
          return ""

      @supervisor.setter
      def supervisor(self, val):
        if not isinstance(val, str):
          raise TypeError('Please provide a string value for the supervisor name')

        if val is not "" and len(val) > 5:
          self.__supervisor = val
        else:
          raise ValueError("Please provide a supervisor name")

    ```

1. After you are happy with your Department class, create a derived class that defines a particular Department. Create some properties that apply **only** to that department.
  
  The classes should, at the very least, set the initial value for the properties that you defined in the base class inside the constructor `__init__`.

  Examples, include HR, IT, Marketing, Sales, etc.

    ```python
    class HumanResources(Department):
      """Class for representing Human Resources department

      Methods: __init__, add_policy, get_policy, etc.
      """

      def __init__(self, name, supervisor, employee_count):
        super().__init__(name, supervisor, employee_count)
        self.policies = set()

      def add_policy(self, policy_name, policy_text):
        """Adds a policy, as a tuple, to the set of policies

        Arguments:
          policy_name (string)
          policy_text (string)
        """

        self.policies.add((policy_name, policy_text))
    ```


1. Create three more classes for departments of your choosing.
1. Create some instances of each department.
1. Assign values to the properties of each.
1. Use `print()` to output the name of each of your department instances.

  ```python
  hr_department = HumanResources(...)
  print(hr_department.name)
  ```
