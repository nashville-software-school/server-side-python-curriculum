# Listing Journal Entries

## Inserting Some Entries

Time to practice the `INSERT INTO` SQL statement.

1. Create all of the moods that you want to support in the Moods table
1. Create a small handful of test journal entries in the JournalEntries table.
1. If you are supporting tagging, create some entries in the Tags table, and some relationships in the EntryTags table.

## Handling GET Requests for Entries

1. Create a `request_handler.py` file in your Python project directory.
1. Create an `entries` package directory and its corresponding `__init__.py` file.
1. Create a `request.py` file in the `entries` package.
1. For now, copy pasta the `request_handler.py` code from the Kennel application that your instructor is walking you through.
1. Have your server listen for the http://localhost:8088/entries URL.
1. Write a `get_all_entries()` function in the entries request module and write the SQL to get all records from the Entries table.
1. If the resource is `entries` return all records from database as JSON representations.