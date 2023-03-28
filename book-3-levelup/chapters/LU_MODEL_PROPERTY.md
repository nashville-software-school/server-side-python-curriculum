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
          'description', 'date', 'time',
          'joined')
```

### List of Events

To set the new `joined` property, you’ll need to loop through the `events` list. Update the `list` method in the `EventView` with the code below. Add it right before using the serializer

```python
uid = request.META['HTTP_AUTHORIZATION']
gamer = Gamer.objects.get(uid=uid)

for event in events:
    # Check to see if there is a row in the Event Games table that has the passed in gamer and event
    event.joined = len(EventGamer.objects.filter(
        gamer=gamer, event=event)) > 0

```

#### Authorization Header

You may have noticed something different in the code block above: `request.META['HTTP_AUTHORIZATION']`. This is how we're going to get the uid from the GET endpoint request.

A payload/body should never be included in a GET request. It will generate errors and fail to function as expected. It's even mentioned on https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/GET:

<img width="765" alt="Screen Shot 2022-11-28 at 9 39 49 PM" src="https://user-images.githubusercontent.com/31781724/204432991-f565500e-3533-4709-bf1f-9096246f9cd9.png">

Important information such as UIDs, tokens, and secret keys should not be passed as parameters through the URL. It could jeopardize that specific information and, as a result, the information of other users. And this is a definite no-no! So, if we can't use the body or url parameters, how will we know which user is making these requests? You'll be passing it through the headers. And we'll get that information from the headers by using `request.META['HTTP AUTHORIZATION']` to get the UID value. You'll need to do some research in the following section to figure out how to pass the uid through the header on the client side. 

> NOTE: When you need to pass user identification in a request, you will now use the header.

## Client Side

### Event Manager Methods

In the event manager, create the functions to be invoked when the current gamer wants to join or leave a specific event. This request has everything the server needs to remove the relationship.

1. The event via the `eventId` parameter
1. The user via the `Authorization` header
     1. Do some research on how to pass the `Authorization` header in your request.
     1. You will see examples of `Bearer <token>` and `Token <token>` but for this, we just want the UID to be passed like `<UID>` without any extra words in the beginning.

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


## Optional Practice

Apply what you've learned so far to any endpoints you've created that take the user ID from the request body (`request.data['uid']` or `request.data['user_id']`) and pass it through the header. Non-GET endpoints included.
