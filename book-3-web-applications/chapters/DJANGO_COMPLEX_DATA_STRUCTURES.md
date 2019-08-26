# Using Joined Models in Views and Templates

Up to now, when you have rendered an individual resource, you have only shown the values of that resource's columns in the database. For example, when viewing the details of a book, you showed the following.

1. Title
1. Author
1. ISBN
1. Year published

That is not all of the information that can be displayed. A book is contained in a specific library and it was added to the inventory by a specific librarian. Those additional details must be retrieved by joining in the corresponding **Library** and **Librarian** entries via the foreign keys in each row.

Time to update the detail view of a Book to show which library it is in and which librarian added it. Open the view file and update the SQL statement to the following.