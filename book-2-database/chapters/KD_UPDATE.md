# Updating Metals

When the user chooses to edit a metal with a new price, the first step in the process is for the client to populate the form with the current values that are stored in the database. Then, when the user has made all of the changes that she wants to, and clicks the "Save" button, a PUT request will be sent to your server.

1. In the `update_metal()` function write an `UPDATE Metals` SQL statement to replace the data in the database with the information sent from the client.
1. Return `True` if there were rows affected by the SQL.
1. Return `False` if there were no rows affected by the SQL.
1. Return the proper status code from the main `request_handler.py` module based on the return value of `update_entry` _(i.e. 204 or 404)_.