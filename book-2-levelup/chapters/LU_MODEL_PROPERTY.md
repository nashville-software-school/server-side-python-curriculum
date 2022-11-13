# Joining and Leaving Events

In the previous chapter, you implemented server side code that let a user join or leave an event.

In this chapter, you are going to implement the react code that will allow gamers to easily join and  leave scheduled events. You will also implement reactive code that will immediately show if the user is currently attending the event or not.

You will learn about custom Django model properties, use a JavaScript ternary statement to show the correct UI element, and use `onClick()` handlers in React.

![animation of joining and leaving events in the client][image-1]

## Learning Objective

* You should be able to identify a custom property in a Django model class.
* You should be able to explain that a custom property exists on class instances, but is not a column in the database.
* You should be able to differentiate between a model property that maps to a column in the database and a custom property.
* You should be able to assign a value to a custom property in a View.

## Server Side

### Custom Model Properties

Normally, every property on a Model class in Django directly reflects a column on a table in the database. Sometimes, though, you need additional properties on a model that are calculated during a request/response cycle with a client.

In this chapter, you are going to add a `joined` custom property to the **`Event`** class that will let the client application know if the currently authenticated user can join a particular event.

Assume there are 4 events.

A user has signed up for events #2 and #4.

When that user is authenticated, and the client requests a list of all events, there should be a new `joined` key on each event. If the user is going to that event it’s value should be `true`, if not `false`. That data is not in the database, but rather calculated by the view logic.

### Model Property

Add the following custom property to `Event` model class. It's a simple property with get/set methods with no additional validation logic. Although it looks like a function, it will act like a regular field. To get the property on the event it’s just `event.joined` no need for parenthesis and to use the setter: `event.joined = True`

> #### `levelup/levelupapi/models/event.py`

```python
@property
def joined(self):
     return self.__joined

@joined.setter
def joined(self, value):
    self.__joined = value
```

### Event Serializer

Update the **`EventSerializer`** class to include the new, custom property.

```python
fields = ('id', 'game', 'organizer',
          'description', 'date', 'time', 'attendees',
          'joined')
```

### List of Events

To set the new `joined` property, you’ll need to loop through the `events` list. Update the `list` method in the `EventView` with the code below. Add it right before using the serializer

```python
gamer = Gamer.objects.get(uid=request.data["user_id"])

for event in events:
    # Check to see if there is a row in the Event Games table that has the passed in gamer and event
    event.joined = len(EventGamer.objects.filter(
        gamer=gamer, event=event)) > 0

```

## Client Side

### Event Manager Methods

In the event manager, create the functions to be invoked when the current gamer wants to join or leave a specific event. This request has everything the server needs to remove the relationship.

1. The event via the `eventId` parameter
1. The user via the `Authorization` token

> **Note:** The `.then(getEvents)` method was also added to the promise chain for `joinEvent()`. Make sure you have that in your function.

```js
export const leaveEvent = eventId => {
  // TODO: Write the DELETE fetch request to leave an event
}

export const joinEvent = eventId => {
    // TODO: Write the POST fetch request to join and event
}
```

### Join and Leave Buttons

Time for all of your hard work to pay off. You will now use the `joined` property on each event to display a Join button, or a Leave button on each event.

In React, you need to update your **`EventList`** page in the client to allow the user to leave or join an event. Inside the `events.map`, use the `joined` property to write a ternary that shows the Leave Button if `joined === true` or shows the Join button if `event.joined === false`. The `onClick` function of each button should call the corresponding fetch call and then update the `events` state

> **Vocabulary:** `condition ? what happens if true : what happens if false` is called a ternary statement in JavaScript. It's a condensed version of an `if..else` block of code that you can use in JSX, because interpolation only supports a single JavaScript statement.

```js
{
  event.joined ?
  // TODO: create the Leave button
  :
  // TODO: create the Join button
}

```

## Try it out

Open your browser and go to the events page.

* Click on a Join button, it should flip to a Leave button
* Click on a Leave button, it should flip to a Join button

[image-1]: ./images/levelup-join-leave.gif
