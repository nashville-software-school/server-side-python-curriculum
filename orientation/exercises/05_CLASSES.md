# Classes

## Setup

```
mkdir -p ~/workspace/python/exercises/classes && cd $_
touch employees.py
```

## Instructions

1. Create a class that contains information about employees of a company and define methods to get/set employee name, job title, and start date.

2. Copy this `Company` class into your module.

    ```
    class Company(object):
        """This represents a company in which people work"""

        def __init__(self, name, title, start_date):
            self.name = name
            self.title = title
            self.start_date = start_date

        def get_name(self):
            """Returns the name of the company"""
            
            return self.name

        # Add the remaining methods to fill the requirements above
    ```

3. Consider the concept of [aggregation](../FND_09_INHERIT_COMPOSE_AGGREGATE.md#aggregation), and modify the `Company` class so that you assign employees to a company. 
4. Create a company, and three employees, and then assign the employees to the company.