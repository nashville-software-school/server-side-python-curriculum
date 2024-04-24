# Creating an Appointment

Now that you have a model, a view, a serializer, and the URL defining the route for appointments, the final step is to create an appointment or two and then get them.

Perform the following requests with your API client.

| Method | URL | Body |
|--|--|--|
| POST | http://localhost:8000/appointments | { "walkerId": 4, "appointmentDate": "2022-11-23" } |
| POST | http://localhost:8000/appointments | { "walkerId": 1, "appointmentDate": "2022-12-01" } |

Verify that you get a response with a 201 status code and that the new appointment is in the response body.

Then request all appointments.

| Method | URL | Body |
|--|--|--|
| GET | http://localhost:8000/appointments | n/a |

Verify that the 2 appointments you created are in the response.
