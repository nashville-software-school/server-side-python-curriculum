# Setting up your database

## Create the database file

1. Create a file named `shipping.db` in the project directory.
2. In VS Code, right-click that file and choose **Open with...**
3. Choose **Configure default editor for '\*db'...** from the menu that appears.
4. Choose **SQLite Viewer** from the next menu that appears.
5. This will open a new panel in VS Code. You can immediately close that one for now.

## Seeding your database

The term _seed the database_ simply means to load your database with some initial data. Most teams you join will have some kind of process to give you a local database with some seeded data to work with.

> 🧨 Before you follow these steps, watch the very short [Run Selected Query Shortcut](https://watch.screencastify.com/v/uU2USCyA64opMoTrZXI9) video to set up a keyboard shortcut for running SQL in VS Code.

1. Open the `shipping.sql` file in VS Code.
2. You will see a comment on line 12.
3. Put your cursor on line 12 and highlight everything from that line of code to the end. You can use **Cmd+Shift+Down Arrow** on Mac, or **Ctrl+Chift+Down Arrow** on Windows.
4. Press **Cmd+r+r** on Mac or **Ctrl+r+r** on Window to run all of the SQL statements. If this doesn't work, perhaps you set up the keyboard shortcut incorrectly. Watch the video again and make sure the configuration is correct.

## Next Step

Once your database is correctly set up, the next step is to understand the goals for the project and starting exploring the API.

[Go to Running API chapter >](./SS_API_IMPERATIVE_INTRO.md)