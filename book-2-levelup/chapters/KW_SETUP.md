# Kennwood API

For this project, you are going to create a database, and a supporting Django REST Framework API that will allow people to build a schedule of attractions to visit when they go to Kennywood Park.

![](./images/kennywood.jpeg)


## Resources

Here are the resources that you need to define in your application. Use dbdiagram.io to build an ERD of the resource fields and relationships.

### Visitors

Each visitor will be able to schedule events for their visit to the park. When a user registers, this is the information to gather.

* First name _(Stored on Django user)_
* Last name _(Stored on Django user)_
* Email address, which will serve as username as well _(Stored on Django user)_
* Number of family members _(Stored on Visitor model)_
* _(optional)_ Phone number _(Stored on Visitor model)_
* _(optional)_ Special requirements _(Stored on Visitor model)_


### Park Areas

Kennywood Park has many different named areas with themed rides inside each one. In the database, you need to store these properties of each park area.

* Area name
* Target population _(kids, adults, all)_

### Attractions

The attractions come in three varieties.

1. Rides - Attractions where visitors sit in a vehicle. Roller coasters, ferris wheels, etc.
1. Games - Games of skill, and arcade games.
1. Themed - Visitors walk through themed structures. Haunted houses, wax museums, etc.

You must record the following data about each attraction.

* Name
* Park area
* Attraction type
* Maximum occupancy _(not applicable for games)_
* Height requirement _(only for rides)_

### Ratings

Any vistor can rate any attraction on a scale of 1-5 and leave a note about their rating.

### Itinerary

Store the relationship between a user and an attraction, along with the time of day, so that the user can have an itinerary.

## React Client Features

Use the following features that your product owner has for the user interface to determine the views/methods needed for the API and the structure of the JSON representations needed in responses.

* User must be able to register a new account.
* User must be able to login with email and password.
* User must be able to see a list of park areas.
* When the user clicks on a park area, the attractions in that park area should be shown to the user.
* User must be able to see a list of all attractions.
* Each attraction must show its name, type, park area, occupancy (if applicable), and height requirement (if applicable).
* User must be able to perform a gesture to add an attraction to the itinerary.
* When a user adds an attraction to the itinerary, user must be prompted to add a time.
* When a user chooses a time for an attraction, if another attraction has been chosen for that time slot, alert the user and do not add attraction to itinerary.
* User must be able to view their profile, which lists the current itinerary, first name, last name, email address, and number of family members.
* When the user views the itinerary, the attractions must be shown in order of time of day, and display the attaction name and park area.
* User must be able to remove an attraction from the itinerary.
* User must be able to update their email address and number of family members.