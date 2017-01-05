# Classes

## Setup

```
mkdir -p ~/workspace/python/exercises/classes && cd $_
touch employees.py
```

## Instructions

Create a class that contains information about employees of a company and define methods to get employee name, job title, and start date.

```
class Company(object):

    def __init__(self, name, title, start_date):
        self.name = name
        self.title = title
        self.start_date = start_date

    def getName(self):
        return self.name

    # Add the remaining methods to fill the requirements above
```
