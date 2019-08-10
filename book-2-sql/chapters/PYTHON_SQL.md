# Writing Python Code to Use SQL Statements

## Using the Translator

Python can not naturually talk to a database. It needs a translator that converts Python code to code that the database understands. In your Python module, you can import that translator. Put the following import statement at the top of your file.

```py
import sqlite3
```

## Getting Data into Python

You can now use the `sqlite3` package to interact with your database. Here's a sample function that gets all students from your Student Exercises database.

```py
def get_all_students():
    with sqlite3.connect('studentexercises.db') as conn:
        db_cursor = conn.cursor()

        db_cursor.execute("""
            SELECT s.Id,
                s.CohortId,
                s.FirstName,
                s.LastName,
                s.SlackHandle
            FROM Student s
        """)

        students = db_cursor.fetchall()
        print(students)
        return students

get_all_students()
```

Run your `student_exercises.py` module in your terminal and see what gets printed out.