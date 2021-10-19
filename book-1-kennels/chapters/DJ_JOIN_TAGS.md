# Add Tags to Entries
To add tags to daily journal, we'll create two new tables and modify the create method for entries. Tags and Entries will have a many-to-many relationship since a tag can be on many entries and we want entries to have more than one tag.

Todo:
1. Create the `tag` table, it should have an id and name
1. Create the `entrytag` table, it should have an id, entry_id (foreign key), and tag_id (foreign key)
1. Insert a few tags into the database
1. Modify the `create_entry` method to loop through a list of tags after adding the entry to the database. Inside the loop, you'll execute another sql command to add a row to the `entrytag` table. 
1. Test in postman to make sure the create works. The data coming from postman or the client should look like this:
    ```json
    {
        "entry": "adding tags",
        "concept": "python",
        "moodId": 2,
        "tags": [2, 3]
    }
    ```
3. Create a new route to get all tags
4. Modify the `get_all_entries` function to also return a list of the tags on an entry. Inside the for...loop you can add in another sql execution to select the tags associated with that entry. You'll need to use the `join` keyword in the sql to follow the relationship from the `entry` table through the `entrytag` table to get to the `tag` table
