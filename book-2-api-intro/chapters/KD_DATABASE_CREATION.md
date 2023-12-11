# Kneel Diamonds Database

## Setup

1. In your project directory, create a `kneeldiamonds.sqlite3` file to be your database.
2. In your project directory, create a `kneel.sql` file where you will store your SQL queries.

## Creating the Tables

Use the `CREATE TABLE` statement to define all of your tables. Here's your first one. You define the other 3 tables.

```sql
CREATE TABLE `Metals`
(
    `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `metal` NVARCHAR(160) NOT NULL,
    `price` NUMERIC(5,2) NOT NULL
);
```

Make sure you set up the foreign key constraints on the Orders table. You have to define all of the columns first, and then separately define the foreign key constraints.

```sql
`metal_id` INTEGER NOT NULL,
FOREIGN KEY(`metal_id`) REFERENCES `Metals`(`id`)
```

This is your first time using SQL to create a relational database. Working with your instruction team is a good idea if you're stuck on anything or need to talk about concepts.

> 🧨 DANGER! This project requires you to create a table named **Order**, but that is a reserved word in SQL, so make sure that you wrap that word in backticks.

Once you have all tables defined in SQL, run the statements and select `kneeldiamonds.sqlite3` from the list of options that appear. Then open the file and verify that all three tables got created.

Next: [Requirements chapter >](./KD_REQUIREMENTS.md)