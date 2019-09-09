# Tracking Student Exercises: Custom Types

You are going to build a console application that tracks exercises that are assigned to students at Nashville Software School. These are the constraints and requirements for your application.


## Student

You must define a custom type for representing a student in code. A student can only be in one cohort at a time. A student can be working on many exercises at a time.

### Properties

1. First name
1. Last name
1. Slack handle
1. The student's cohort
1. The collection of exercises that the student is currently working on

## Cohort

You must define a type for representing a cohort in code.

1. The cohort's name (Evening Cohort 6, Day Cohort 26, etc.)
1. The collection of students in the cohort.
1. The collection of instructors in the cohort.

## Instructor

You must define a type for representing an instructor in code.

1. First name
1. Last name
1. Slack handle
1. The instructor's cohort
1. The instructor's specialty (e.g. dad jokes, excitement, dancing, etc.)
1. A method to assign an exercise to a student

## Exercise

You must define a type for representing an exercise in code. An exercise can be assigned to many students.

1. Name of exercise
1. Language of exercise (JavaScript, Python, CSharp, etc.)

## Objective

The learning objective of this exercise is to practice creating instances of custom types that you defined with `class`, establishing the relationships between them, and practicing basic data structures in Python.

## Entity Relationship Diagram

First, build an ERD based on these above requirements using [dbdiagram.io](https://dbdiagram.io).

## Setup

> **Note:** Make sure that each class you define is in its own file.

```sh
mkdir -p ~/workspace/python/StudentExercises && cd $_
touch main.py student.py cohort.py instructor.py exercise.py
code .
```

Once you have defined all of your custom types, go to `main.py`, import the classes you need, and implement the following logic.

1. Create 4, or more, exercises.
1. Create 3, or more, cohorts.
1. Create 4, or more, students and assign them to one of the cohorts.
1. Create 3, or more, instructors and assign them to one of the cohorts.
1. Have each instructor assign 2 exercises to each of the students.

## Challenge

Continuing inside of `main.py` with the instances of the classes you made previously, create the lists below.

##### Example:
If I had a student instance referenced by the variable `ivan`:
```py
students = [ivan]
```


1. Create a list of students. Add all of the student instances to it.
    ```py
    students = list()
    ```
1. Create a list of exercises. Add all of the exercise instances to it.
    ```py
    exercises = list()
    ```

Now, generate a report that displays which students are working on which exercises.

##### Example

```sh
Ivan is working on Kandy Korner, Stocks Report, and Planet List.
```
