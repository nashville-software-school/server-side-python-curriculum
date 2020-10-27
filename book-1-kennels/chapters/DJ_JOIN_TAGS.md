# Add Tags to Entries
To add tags to daily journal, we'll create two new tables and modify the create method for entries. Tags and Entries will have a many-to-many relationship since a tag can be on many entries and we want entries to have more than one tag.

Todo:
1. Create the `tag` table, it should have an id and name
1. Create the `entry_tag` table, it should have an id, entry_id (foreign key), and tag_id (foreign key)
1. Insert a few tags into the database
1. Modify the create_entry method to accept a list of tag id's. You'll loop through the list to add rows to the `entry_tag` table 
1. Test in postman to make sure the create works, 
1. Create a new route to get all tags
1. Modify the get_all_entries function to also return a list of the tags on an entry

