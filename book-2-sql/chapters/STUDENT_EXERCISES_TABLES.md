# Student Exercises Database

## Setup

```sh
mkdir -p ~/workspace/python/exercises/studentexercises && cd $_
touch studentexercises.db
tableplus studentexercises.db
```

This will create and open a completely blank SQLite database. In this chapter, you are going to be learning the usage of the following SQL statements.

1. `CREATE TABLE`
1. `INSERT INTO`

## Defining your Tables

Read the instructions below and create an ERD of the database before you start creating the tables and inserting the data. Make sure that each table has a primary key column and foreign key constraints for the relationships.

### Cohort

You must define a table to store data about a cohort.  The table must have the following columns.

1. The cohort's name (Evening Cohort 6, Day Cohort 25, etc.)

### Student

You must define a table to store data about a student. A student can only be in one cohort at a time. A student can be working on many exercises at a time. The table must have the following columns.

1. First name
1. Last name
1. Slack handle
1. The student's cohort


### Instructor

You must define a table to store data about an instructor. The table must have the following columns.

1. First name
1. Last name
1. Slack handle
1. The instructor's cohort
1. The instructor's specialty (e.g. jokes, snack cakes, dancing, etc.)

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

### Exercises

1. Create a new "**Console App (.NET Core)**" project.
1. Add the `System.Data.SqlClient` nuget package to your project.
1. Create a `Repository` class to interact with the `StudentExercises` database you created in Student Exercises Part 3.
1. Write the necessary C# code in `Repository.cs` and `Program.cs` to perform the following actions. Make sure to print results of each action to the console.
    1. Query the database for all the Exercises.
    1. Find all the exercises in the database where the language is JavaScript.
    1. Insert a new exercise into the database.
    1. Find all instructors in the database. Include each instructor's cohort.
    1. Insert a new instructor into the database. Assign the instructor to an existing cohort.
    1. Assign an existing exercise to an existing student.

## Challenges

1. Add the following to your program:
    1. Find all the students in the database. Include each student's cohort AND each student's list of exercises.
    1. Write a method in the `Repository` class that accepts an `Exercise` and a `Cohort` and assigns that exercise to each student in the cohort IF and ONLY IF the student has not already been assigned the exercise.

## Advanced Challenge

>**NOTE**: _Only work on this challenge if you've completed ALL the other exercises assigned during Orientation._

1. Modify your program to present the user with a menu and accept input from the user using the [Console.ReadLine()](https://docs.microsoft.com/en-us/dotnet/api/system.console.readline?redirectedfrom=MSDN&view=netframework-4.7.2#System_Console_ReadLine) method.
    Use the following program as an example for creating a menu.
    ```cs
    using System;
    using System.Linq;
    namespace UserInputExample
    {
        class Program
        {
            static void Main(string[] args)
            {
                while (true)
                {
                    Console.WriteLine();
                    Console.WriteLine("------------------------");
                    Console.WriteLine("Choose a menu option:");
                    Console.WriteLine("1. Shout it out.");
                    Console.WriteLine("2. Reverse it.");
                    Console.WriteLine("3. Exit.");

                    string option = Console.ReadLine();
                    if (option == "1")
                    {
                        Console.Write("What should I shout? ");
                        string input = Console.ReadLine();
                        Console.WriteLine(input.ToUpper() + "!!!");
                    }
                    else if (option == "2")
                    {
                        Console.Write("What should I reverse? ");
                        string input = Console.ReadLine();
                        Console.WriteLine(new string(input.Reverse().ToArray()));
                    }
                    else if (option == "3")
                    {
                        Console.WriteLine("Goodbye");
                        break; // break out of the while loop
                    }
                    else
                    {
                        Console.WriteLine($"Invalid option: {option}");
                    }
                }
            }
        }
    }
    ```
     Create menu options to allow the user to perform the following tasks:
    1. Display all students.
    1. Display all instructors.
    1. Display all exercises.
    1. Display all cohorts.
    1. Search students by last name.
    1. Create a new cohort.
    1. Create a new student and assign them to an existing cohort.
    1. Create a new instructor and assign them to an existing cohort.
    1. Display all students in a given cohort.
    1. Move an existing student to another existing cohort.
    1. List the exercises for a given student.
    1. Assign an existing exercise to an existing student.

>**NOTE**: C#'s [switch statement](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/switch) may simplify your menu code.