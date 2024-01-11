# Showing User's Rocks

In the client application, there was a navigation element labeled **My Rocks**. When this view is loaded, only the rocks that have been created by the authenticated user will appear - not all rocks.

How can the client request a subset of rocks, meaning rocks that only meet a certain condition? This sounds like a filtering operation, and that is one of the main purposes of query string parameters in URLs.

Here are some sample URLs and their purpose.

> You can make the query string keys and values ANYTHING you want, as long as the client and the server both agree on their definition and purpose.

| URL | Expected result |
|--|--|
| /rocks | Give me all rocks |
| /rocks?weight=heavy | Give me rocks which have a weight of 4kg or more |
| /rocks?type=4 | Give me shale rocks |
| /rocks?weight=light&type=2 | Give me igneous rocks that weigh less than 4kg |
| /rocks?owner=current | Give me rocks owned by the current user |

It is this last URL that you will focus on in this chapter.

## Accessing Query String Parameters Values

With Django, you access query string parameters with the following property on the request.

```py
request.query_params.get('theKeyYouWant', None)
```

This will get the value of the query string parameter - if it exists in the URL. If it doesn't exist, it will default to **None**. Let's look at how to access the values from the examples above.

URL: `/rocks?weight=heavy`

```py
request.query_params.get('weight', None) # 'heavy'
request.query_params.get('owner', None) # None
request.query_params.get('type', None) # None
```

URL: `/rocks?weight=light&type=2`

```py
request.query_params.get('weight', None) # 'light'
request.query_params.get('owner', None) # None
request.query_params.get('type', None) # 2
```

URL: `/rocks?owner=current`

```py
request.query_params.get('weight', None) # None
request.query_params.get('owner', None) # 'current'
request.query_params.get('type', None) # None
```

## Filtering Query Set

Currently in the `list()` method for the rock view, you are getting all records from the database by default.

```py
try:
    rocks = Rock.objects.all()
    serializer = RockSerializer(rocks, many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)

except Exception as ex:
    return HttpResponseServerError(ex)
```

Update this code to see if the query parameter of `owner` exists, and if its value is "current". If both of those are true, use the `filter()` ORM method to only get the user's rocks.

```py
# Get query string parameter
owner_only = self.request.query_params.get("owner", None)

try:
    # Start with all rows
    rocks = Rock.objects.all()

    # If `?owner=current` is in the URL
    if owner_only is not None and owner_only == "current":
        # Filter to only the current user's rocks
        rocks = rocks.filter(user=request.auth.user)

    serializer = RockSerializer(rocks, many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)
except Exception as ex:
    return HttpResponseServerError(ex)
```

Note that you are using the `request.auth.user` object again that Django automatically creates for you that represents the currently authenticated user.

Test it in Postman. You are encouraged to try it with two different tokens to truly verify that each user only gets their rocks back.

## Full Stack Work

Time to implement this feature in your React client. If you look in the **ApplicationViews** component, you can see that it renders **RockList** when the route is `/allrocks` and `/mine`. You can follow one of two strategies.

1. Use **RockList** to render both kinds of data
2. Create another component called **UserRockList** that performs a fetch call to use the query string parameter.

With either strategy, you need to render a **Delete** button for each rock if the user is looking at their rocks list.

![](./images/user-rock-list-with-delete.png)

Then implement the delete button by performing a DELETE request that you supported in your API in the last chapter. Make sure you get the new state after the delete is successful.

## Video Walkthrough

Here is a 4:24 minute walkthrough of implementing the code in the client to render user rocks.

[<img src="./images/video-play-icon.gif" height="75rem" />](https://watch.screencastify.com/v/x5TTolsqLiK7oRepLqd1)

Here is a 4:26 minute walkthrough of implementing the code in the client to delete user rocks.

[<img src="./images/video-play-icon.gif" height="75rem" />](https://watch.screencastify.com/v/7vMAJPKUM1tbgeO18vYt)
