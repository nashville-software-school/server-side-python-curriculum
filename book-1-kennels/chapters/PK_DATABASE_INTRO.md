# Creating Database Tables for Nashville Kennels

## Videos to Watch First


## Creating Database File


## Creating Connection to Database File


## Creating Tables

The `CREATE TABLE` SQL statement creates a table in a database to store a particular resource. Columns, or fields, are defined for each table to store the individual properties of that resource.

Time to create a table for each of the four resources in this application.

1. Locations
1. Customers
1. Animals
1. Employees

```sql
CREATE TABLE `Location` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`name`	TEXT NOT NULL,
	`address`	TEXT NOT NULL
);

CREATE TABLE `Customer` (
    `id`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `name`    TEXT NOT NULL,
    `address`    TEXT NOT NULL,
    `email`    TEXT NOT NULL
);


CREATE TABLE `Animal` (
	`id`  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`name`  TEXT NOT NULL,
	`breed` TEXT NOT NULL,
	`customer_id` INTEGER NOT NULL,
	`location_id` INTEGER,
	FOREIGN KEY(`customer_id`) REFERENCES `Customer`(`id`),
	FOREIGN KEY(`location_id`) REFERENCES `Location`(`id`)
);


CREATE TABLE `Employee` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`name`	TEXT NOT NULL,
	`address`	TEXT NOT NULL,
	`location_id` INTEGER NOT NULL,
	FOREIGN KEY(`location_id`) REFERENCES `Location`(`id`)

);
```

## Inserting Starter Data

The `INSERT INTO` SQL statement allows you to enter in the actual data about individual resources that will be stored in a table. The values have to match the order in which the columns were defined in the `CREATE TABLE` statements above, so yes, order matters.

```sql
INSERT INTO `Location` VALUES (null, 'Nashville North', "64 Washington Heights");
INSERT INTO `Location` VALUES (null, 'Nashville South', "101 Penn Ave");


INSERT INTO `Employee` VALUES (null, "Madi Peper", "35498 Madison Ave", 1);
INSERT INTO `Employee` VALUES (null, "Kristen Norris", "100 Main St", 1);
INSERT INTO `Employee` VALUES (null, "Meg Ducharme", "404 Unknown Ct", 2);
INSERT INTO `Employee` VALUES (null, "Hannah Hall", "204 Empty Ave", 1);
INSERT INTO `Employee` VALUES (null, "Leah Hoefling", "200 Success Way", 2);


INSERT INTO `Customer` VALUES (null, "Mo Silvera", "200 Success Way", "mo@silvera.com");
INSERT INTO `Customer` VALUES (null, "Bryan Nilsen", "500 Internal Error Blvd", "bryan@nilsen.com");
INSERT INTO `Customer` VALUES (null, "Jenna Solis", "301 Redirect Ave", "jenna@solis.com");
INSERT INTO `Customer` VALUES (null, "Emily Lemmon", "454 Mulberry Way", "emily@lemmon.com");



INSERT INTO `Animal` VALUES (null, "Snickers", "Dalmation", 4, 1);
INSERT INTO `Animal` VALUES (null, "Jax", "Beagle", 1, 1);
INSERT INTO `Animal` VALUES (null, "Falafel", "Siamese", 4, 2);
INSERT INTO `Animal` VALUES (null, "Doodles", "Poodle", 3, 1);
INSERT INTO `Animal` VALUES (null, "Daps", "Boxer", 2, 2);

```