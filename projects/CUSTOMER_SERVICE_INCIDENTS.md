# Customer Service Incident Portal

## Requirements

> **Unit Testing**: Management will not accept a project for which implmentation code was written before a unit test. If you have questions about this, you need to speak with your manager.

Your team must build a customer service application that allows our customer service representatives keep track of customer issues. There will be several menus of options to navigate, and you will also be writing a report that customer service managers will be using to keep track of trends.

### Access Prompt

```
====================================
BANGAZON INC CUSTOMER SERVICE PORTAL
====================================

Enter your first and last name to start. Type "new user" to create a new user account.
> 
```

#### Valid User

Once the user enters in a valid first name and last name that exists in the database, the user will be presented with the main menu.

#### New User

If the user entered "new user" at the prompt, display three prompts to create a new account in the `Employee` table.

```
====================================
BANGAZON INC CUSTOMER SERVICE PORTAL
====================================

First name
> 

Last name:
>

Department:
1. Apparel
2. Electronics
3. Toys & Games
4. Books
5. Home Furnishings
>
```

### Main Menu

```
====================================
BANGAZON INC CUSTOMER SERVICE PORTAL
====================================

1. Create Incident
2. List My Incidents
X. Exit
```

### Create Incident

```
====================================
BANGAZON INC CUSTOMER SERVICE PORTAL
====================================

Enter customer name (<First> <Last>):
>
```

After the customer representative enters in the customer's first and last name, you need to create a connection to the Bangazon Product Database to find that customer's information and any orders that the customer has completed.

Then display a menu where the rep can choose the order for which the customer has an issue.

```
====================================
BANGAZON INC CUSTOMER SERVICE PORTAL
====================================

Choose a customer order:
1. Order #9: 01/01/2011
2. Order #32: 03/14/2011
3. Order #151: 11/07/2011
4. Order #236: 06/30/2012
5. Order #783: 01/12/2013
X. Exit
>
```

After an order has been selected, then prompt for the incident type.

```
====================================
BANGAZON INC CUSTOMER SERVICE PORTAL
====================================

Choose incident type:
1. Defective Product
2. Product Not Delivered
etc...
X. Exit
```

Then display an incident screen where the customer service rep can enter in the resolution.

```
INCIDENT
==============================================================
Customer: Smith, John                            Order: 151
Incident Type: Defective Product

Labels:
* This order is refundable
* This order is replaceable
* Non-Tranactional incident
==============================================================
Enter resolution:
>
```

Make sure you have a class definition for each type of incident in your database. Use Python's ability to do multiple inheritance to share common properties, and implement the correct methods or properties on the appropriate types.

1. `Defective Product` and `Product Not Delivered` incident types are replaceable.
1. `Defective Product` and `Product Not Delivered`, and `Fraud` incident types are refundable.
1. `Request for Information` and `Shipping Info Update` incident types are non-transactional (i.e. just for information and not complaints).

Based on which interface the specific incident type implements will determine which label(s) are displayed on the incident screen above (see the `Labels` section).

For example, you could have a class named `Refundable` with a single method on it named `is_refundable(self)` that returns `True`. Extrapolate from there.

### List Incidents

```
====================================
BANGAZON INC CUSTOMER SERVICE PORTAL
====================================

1. Smith, Frank : Order 616
2. Johansson, Karl : Order 909
3. Levinson, Sarah : Order 112
4. Winnery, Laura : Order 9
5. Killigrew, Tekisha : Order 1130
6. Gonzalez, Juan : Order 445
7. Inik, Sh'Quanna : Order 919
8. Andropov, Yuri : Order 1024
>
```

As soon as an incidient number is chosen, the incident screen (_see above_) should be shown, if the incident is open.

If the incident is closed, meaning a resolution has been entered, no prompt for resolution should be shown.

```
INCIDENT
==============================================================
Customer: Smith, John                            Order: 151
Incident Type: Defective Product

Labels:
* This order is refundable
* This order is replaceable
* Non-Tranactional incident

Resolution:
Order was re-fulfilled from warehouse XD778 and will be
delivered to same address
==============================================================
```

### Power Up: Manager Incident Report

> Only attempt this Power Up if you have fulfilled **all** base requirements.

1. Add a new item to the main menu.

    ```
    ====================================
    BANGAZON INC CUSTOMER SERVICE PORTAL
    ====================================

    1. Create Incident
    2. List My Incidents
    3. Incident Report
    X. Exit
    ```

1. Add a new column to the `Employee` database named `Administrator` that is boolean.
1. Use an `INSERT` SQL statement to add an administrator record to the `Employee` table.
1. Access the program as the administrator account, and choose the Incident Report option.

Produce the following output.

```
******************************************************
*                                                    *
*                 INCIDENTS REPORT                   *
*                                                    *
******************************************************

Representative                Open        Closed/Month
======================================================
Henningsworth, Chad           2           2
Jennings, Jenny               3           4
Ross, Jamal                   1           3
Eorling, Johan                1           3
Thompson, Charisse            3           5
Jones, B'lake                 2           3
Malone, Tyler                 0           1
```

## Resources

### Seed Data

> **Note:** Any SQL that you need to populate your database needs to be checked into source control. Your database file should **never** be in source control - only the migrations.

Save the following SQL statements into a `populate.sql` file in your project directory. Run the statements against your database to have some initial data. You may add more departments or incident types if you wish.

```
/*
Add some default departments
 */
INSERT INTO Department (Label) VALUES ('Apparel');
INSERT INTO Department (Label) VALUES ('Electronics');
INSERT INTO Department (Label) VALUES ('Toys & Games');
INSERT INTO Department (Label) VALUES ('Books');
INSERT INTO Department (Label) VALUES ('Home Furnishings');

/*
Add some default incident types
 */
INSERT INTO IncidentType (Label) VALUES ('Defective Product');
INSERT INTO IncidentType (Label) VALUES ('Product Not Delivered');
INSERT INTO IncidentType (Label) VALUES ('Unhappy With Product');
INSERT INTO IncidentType (Label) VALUES ('Request For Information');
INSERT INTO IncidentType (Label) VALUES ('Fraudulent Charge');
INSERT INTO IncidentType (Label) VALUES ('Shipping Info Update');
```

### Unit Testing

You got an introduction to unit testing during your front end course work. On the server side, unit testing becomes easier, and more straightfoward because you don't have user interfaces to worry about. No functional testing at all.

Server side code is all about constrained inputs and verifiable outputs. Perfect for unit testing.

Read a [walkthrough of setting up unit tests](https://docs.python.org/3.5/library/unittest.html) in Python.

Just like with Jasmine for your JavaScript, you should use your unit tests as part of your design stage. Write as many unit tests as you can for your initial classes and methods. Once you feel you have good coverage for the basic logic of your application, then you begin writing simple implementations of the code in order to make the tests pass.

#### Test Discovery

Read the [Test Discovery section](https://docs.python.org/3.3/library/unittest.html#unittest-test-discovery) of the Python docs. It explains how you can run all tests inside a directory. This allows you to split your unit test suite into many, smaller, more maintainable modules, and the use a pattern matcher to find tests in all matching files.

```
python -m unittest discover -s . -p "Test*.py" -v
```

#### Code Coverage

You can use the Python tool [coverage.py](https://coverage.readthedocs.io/en/latest/), to ensure that your test suite has [100% coverage](http://blog.liw.fi/posts/unittest-coverage/) of your application's logic.

