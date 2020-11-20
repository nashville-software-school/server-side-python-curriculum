# Events by Gamer Report

You need to generate another HTML report that displays the events that each gamer has signed up for. You are going to follow the exact same process that you did for the previous report.

1. Create a `levelupreports/views/users/eventsbyuser.py` module.
1. Create a `templates/users/list_with_events.html` template.
1. Be efficient and copy pasta the code from your previous report module. Make sure you change the name of the function.
1. Write and test the SQL to get the events that each user signed up for and replace the SQL in the report module.
1. The data structure you need to build is very similar to the one in the previous report.
    ```json
    {
        1: {
            "organizer_id": 1,
            "full_name": "Molly Ringwald",
            "events": [
                {
                    "id": 5,
                    "date": "2020-12-23",
                    "time": "19:00",
                    "game_name": "Fortress America"
                }
            ]
        }
    }
    ```
1. Update the context dictionary with an appropriate key name.
1. Build the Django template to produce the HTML you want.