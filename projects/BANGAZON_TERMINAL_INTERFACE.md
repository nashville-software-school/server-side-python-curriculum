# Bangazon

## The Command Line Ordering System

In this group project, you will be allowing a user to interact with a basic product ordering database.

## Ordering System Interface

### Main Menu

```bash
*********************************************************
**  Welcome to Bangazon! Command Line Ordering System  **
*********************************************************
1. Create a customer account
2. Choose active customer
3. Create a payment option
4. Add product to shopping cart
5. Complete an order
6. See product popularity
7. Leave Bangazon!
>
```

### Create Customer

```bash
Enter customer name
>

Enter street address
>

Enter city
>

Enter state
>

Enter postal code
>

Enter phone number
>
```

### Choose active customer

```bash
Which customer will be active?
1. John Q. Public
2. Svetlana Z. Herevazena
>
```


### Create Payment Option

```bash
Enter payment type (e.g. AmEx, Visa, Checking)
>

Enter account number
>
```

### Add Product to an Order

> **Note:** These are examples. Add your own product names, please.

To make it easier to add multiple products, when the user selects a product to order, display the menu of products again. Make sure the last option of *Back to main menu* so the user can specify that no more products are needed.

```bash
1. Diapers
2. Case of Cracking Cola
3. Bicycle
4. AA Batteries
...
9. Done adding products
```

### Complete an Order

##### If no products have been selected yet

```bash
Please add some products to your order first. Press any key to return to main menu.
```

##### If there are current products in an order

```bash
Your order total is $149.54. Ready to purchase
(Y/N) >

# If user entered Y
Choose a payment option
1. Amex
2. Visa
>

Your order is complete! Press any key to return to main menu.

# If user entered N, display the main menu again
```

Once the order is complete, show the main menu again, where the user can start creating another order.

### See Product Popularity

When selecting this option, you will produce a command line report that looks like the following.

```bash
Product           Orders     Customers  Revenue
*******************************************************
AA Batteries      100         20        $990.90 
Diapers           50          10        $640.95
Case of Cracki... 40          30        $270.96
*******************************************************
Totals:           190         60        $1,902.81

-> Press any key to return to main menu
```

1. The product column must be 18 characters wide, and will display a maximum of 17 characters for the product name.
1. The orders column must be 11 characters wide.
1. The customers column must be 11 characters wide.
1. The revenue column must be 15 characters wide.

# Requirements

You will create a series of prompts that will allow the user to create various types of data in your ordering system.

1. Start with writing unit tests. As a group, determine the core functionality of the application. Define classes and methods that you think you need to build. Do that before writing the implementation code for core logic. DO NOT WRITE TESTS FOR THE USER INTERFACE (menu and prompts).
1. All classes and methods must be fully documented with docstrings.

## Test Discovery

Read the [Test Discovery section](https://docs.python.org/3.3/library/unittest.html#unittest-test-discovery) of the Python docs. It explains how you can run all tests inside a directory. This allows you to split your unit test suite into many, smaller, more maintainable modules, and the use a pattern matcher to find tests in all matching files.

```
python -m unittest discover -s . -p "Test*.py" -v
```

## Optional: Code Coverage

You can use the Python tool [coverage.py](https://coverage.readthedocs.io/en/latest/), to ensure that your test suite has [100% coverage](http://blog.liw.fi/posts/unittest-coverage/) of your application's logic.

