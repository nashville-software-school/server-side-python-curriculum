# Bangazon Data Model

## Overview

You need to build the ERD and initial data model for the Bangazon, LLC organization. This will be the base database schema that you will be using for many of the applications that will be built for the company.

## Instructions

### ERD

Build an ERD to define the properties of the following resources and the relationships between them. There are some properties defined for each resources, but they are the bare minimum. Use your own life skills and knowledge to add appropriate properties to each one where you see fit.

> **Technical Note:** These are the main resources that are needed in the database and is *not* an all-inclusive list of tables that should be created.

#### Employees
* An employee can only be assigned to one department
* An employee can sign up for one, or more, training programs

#### Departments
* A department has a supervisor, a specific kind of Employee
* A department has an expense budget

#### Computers
* Track when a computer was purchased by the company
* Track when a computer was decommissioned by the company
* A computer can only be assigned to one employee at a time, but can be assigned to multiple employees over its lifetime.

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
* If a customer does not interact with the system for a long period of time, they will need to be marked as inactive in the database

### Create tables and data

Create a SQL script that is able to build the tables that you defined in your ERD. The script must also create a few rows in each table.

> **Pro tip:** Remember to ask the two questions when dealing with data relationships. Can X have many Y? Can Y have many X?
