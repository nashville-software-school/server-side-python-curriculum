# Daily Journal Database

## Setup

1. Create a new sub-directory in your `~/workspace` directory for this project. A good name would be `daily-journal-server`.
1. In your project directory, create a `dailyjournal.db` file to be your database.

## Daily Journal ERD

Your first task is to create an ERD for Daily Journal if you haven't done so yet. What are the resources for the application?

1. Journal entries
1. Moods
1. Tags _(if you were able to implement this in Book 2 Chapter 17 of the client side)_

That means you need two tables in your database.

What fields are needed for the `JournalEntries` table? Look at the properties you currently have in your JSON file for the answer.

What fields are needed for the `Moods` table? Look at the properties you currently have in your JSON file for the answer.

If you were able to implement the tagging feature for Daily Journal, what fields are needed for the `Tags` and `EntryTags` tables? Look at the properties you currently have in your JSON file for the answer.

What foreign key constraints need to be set up?

1. There is one foreign key on the JournalEntries table.
1. There are two foreign keys on the EntryTags table.

## Creating the Tables

Use the `CREATE TABLE` statement to define all of your tables. Also make sure you set up the foreign key constraints where needed.

```sql
FOREIGN KEY(`column`) REFERENCES `Table`(`column`)
```

This is your first time using SQL to create a relational database. Working with your instruction team is a good idea if you're stuck on anything or need to talk about concepts.
