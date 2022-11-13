
# Editing Games and Events in React

Create the `UpdateGame` and `UpdateEvent` form components in the React app. For each, you'll need:

1. A page that renders a form
2. The form should be filled out with the existing data
3. When changes are made in the form the state of the component updates
4. When the submit button is clicked, it should make a PUT request to the correct resource with the updated data in the body
5. After the fetch call is resolved, the page should route to the game/event’s detail page

## Errors

If the server side `PUT` request works in Postman but not in react, make sure you’re sending the right keys on the object you’re passing to the server. `KeyErrors` happen when a key does not exist on a dictionary. Say you’re getting an error that says `Key of 'gameTypeId' does not exist on request.data dictionary`, you should check the payload in the network tab of your browser to see exactly what is being sent to the server.
