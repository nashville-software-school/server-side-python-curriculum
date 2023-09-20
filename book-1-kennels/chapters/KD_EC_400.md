# Prevent Invalid Orders

In Kneel Diamonds, if the client performs a POST request, but the body of the request contains an invalid object - meaning there are any required keys missing - respond with a JSON encoded dictionary with a "message" key and a helpful message about why the POST is rejected.

Make sure the response has a 400 status code so that the client knows that it was bad request.
