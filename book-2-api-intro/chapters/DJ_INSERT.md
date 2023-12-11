# Creating a New Journal Entry

When your Daily Journal client performs a POST operation to http://localhost:8088/entries with a JSON repqresentation of an entry object in the body, your server should handle the request and invoke a `create_journal_entry()` function.

The creation function should contain the `INSERT INTO` SQL statement to get the information stored in the `JournalEntries` table.
