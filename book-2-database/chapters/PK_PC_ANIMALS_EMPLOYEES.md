# Assigning Employees to Animals

In the React client that you are using for Kennels, if you look at the details of an employee, you see the following text for each one.

> Not assigned to any animals

This is because your database, and supporting API code, does not have any relationship between employees and animals. Since the client clearly wants to display this information, you need to augment your server to support this relationship.

## Data Relationships

For the Nashville Kennels organization, whenever an animal is checked in, there may be multiple employees at that location that are assigned for its care. One employee may be responsible for cleaning its kennel, while another is responsible for treatment.

Likewise, a single employee will be assigned to care for multiple animals during the day.

What kind of relationship exists between these two resources?

Once you determine that use the appropriate SQL statements to modify your database and create new data to relate some animals to some employees.

## Database Model

The next step is to look at your **`Employee`** model class and determine if any new properties need to be added to it. Consider that the client wants to display an employee and that the animals being cared for by that employee should be a property of it.

## Getter Function

Once that is done, you now need to focus on the `get_single_employee()` function. The SQL statement needs to be augmented to select all of the related animals for the requested employee. You will need to use the `JOIN` clause to get all of the needed information, and practice using aliases on column names to make each one unique in the `SELECT` statement.

We'll give you some starter hints and code for your logic. You need to swap out the `fetchone()` method to a `fetchall()` since you'll be getting multiple rows back. Which means you'll need a `for..in` loop to iterate that dataset.

Here's some starter code for your `for` loop.

```py
assigned_animals = []
employee = None

for row in dataset:
    if employee is None:
        employee = Employee(...) # You define the right arguments
```

That's all we're going to give you. Feel free to reach out to your coaches to discuss your ideas and flesh out a strategy, but remember that for Pioneer chapters, we won't give you any of the code, but we will discuss ideas with you.
