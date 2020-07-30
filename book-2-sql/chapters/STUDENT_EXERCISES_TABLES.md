# Student Exercises Database

## Setup

```sh
cd ~/workspace/python/StudentExercises && cd $_
touch studentexercises.db
```

This will create and open a completely blank SQLite database. In this chapter, you are going to be learning the usage of the following SQL statements.

1. `CREATE TABLE`
1. `INSERT INTO`

## References

* [CREATE TABLE tutorial with examples](http://www.sqlitetutorial.net/sqlite-create-table/)
* [INSERT INTO tutorial with examples](http://www.sqlitetutorial.net/sqlite-insert/)

## Defining your Tables

Read the instructions below and create an ERD of the database before you start creating the tables and inserting the data. Make sure that each table has a primary key column and foreign key constraints for the relationships.
In this part of building your application, you will be creating the database tables and the data that you will be querying in your application logic later.


### Cohort

You must define a table to store data about a cohort. We are giving you the SQL statement for this table, but you have to write the rest of them.

The table must have the following columns.

1. The cohort's name (Evening Cohort 6, Day Cohort 26, etc.)

```sql
CREATE TABLE Cohort (
    Id	   INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Name   TEXT NOT NULL UNIQUE
);
```

### Student

You must define a table to store data about a student. A student can only be in one cohort at a time. A student can be working on many exercises at a time. The table must have the following columns.

1. First name
1. Last name
1. Slack handle
1. The student's cohort

Make sure you create the foreign key constraint as well.

```sql
CREATE TABLE Student (
    ...
    FOREIGN KEY(CohortId) REFERENCES Cohort(Id)
);
```

### Instructor

You must define a table to store data about an instructor. The table must have the following columns.

1. First name
1. Last name
1. Slack handle
1. The instructor's cohort
1. The instructor's specialty (e.g. dad jokes, excitement, dancing, etc.)

### Exercise

You must define a table to store data about an exercise. An exercise can be assigned to many students. The table must have the following columns.

1. Name of exercise
1. Language of exercise (JavaScript, Python, CSharp, etc.)

### Mystery Intersection Table

If you designed your ERD correctly, you should know that there is one more table that you need to define in your database. Create that table now with its primary key and required foreign key constraints.

If you get stuck, or have questions, talk to your instruction team.

## Inserting Sample Data

Use the `INSERT INTO` SQL statement to create...

1. 3 cohorts
1. 5 exercises
1. 3 instructors
1. 7 students _(don't put all students in the same cohort)_
1. Assign 2 exercises to each student

Here's a sample insert statement for an exercise.

```sql
INSERT INTO Exercise (Name, Language)
VALUES ('Kandy Korner', 'JavaScript');
```
