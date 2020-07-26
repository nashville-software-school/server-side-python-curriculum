# Bangazon ERD

## Overview

You need to build the ERD for the Bangazon, Inc. organization. This will be the base database schema that you will be using for many of the applications that will be built for the company.

## Instructions

### ERD

Build an ERD to define the properties of the following resources and the relationships between them.

> **Note:** These are the main resources that are needed in the database and is *not* an all-inclusive list of tables that should be created.

> **Note:** Remember each resource should include an identifier and identifiers are used when defining relationships between resources.

> **Note:** Remember to ask the two questions when dealing with data relationships. Can X have many Y? Can Y have many X?

#### Employees
* An employee can only be assigned to one department
* An employee can sign up for one, or more, training programs

#### Departments
* A department has a supervisor, a specific kind of Employee
* A department has an expense budget

#### Computers
* Track when a computer was purchased by the company
* Track when a computer was decommissioned by the company
* A computer can only be assigned to one employee at a time
* If the IT manager buys a brand new laptop for someone who quits in 3 months, he doesn't throw away the computer
* An employee's computer may malfunction

#### Training Programs
* A training program must have a start date
* A training program must have an end date
* A training program must have maximum attendees specified

#### Product Types
* These are categories of Products

#### Products
* A product can only have one type
* A product has a price
* A product has a title
* A product has a description
* A product has a quantity (e.g. Trey is selling 3 computers)
* Products will be created by customers, so make sure that you have the appropriate column on the Product table

#### Orders
* A customer can only have one active order at a time

#### Payment Types
* A customer can have multiple payment types (Visa, Amex, bank account, etc)
* A payment type must have an account number
* An order must be given a payment type before it is complete, but it not needed when order is created

#### Customers
* A customer's first and last name should be recorded separately
* The date that a customer created an account must be tracked
* If a customer does not interact with the system for over 240 days, they will be marked as inactive


## Populating the Database

Once you have have built the ERD and had it approved by one of the instruction team, you must write a SQL script for populating a couple rows in each table.

1. Start with DELETE statements to wipe out the data in the tables.
1. Then DROP TABLE statements to remove the tables.
1. Next should be your CREATE TABLE statements with the CONSTRAINT keywords for the foreign keys.
1. Last should be the INSERT statements for seeding the database with data.
