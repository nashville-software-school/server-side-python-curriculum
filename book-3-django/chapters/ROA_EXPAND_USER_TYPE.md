# Expanding Foreign Keys

Using Django REST Framework, expanding foreign keys involves utilizing serializers within serializers.

Currently, your **RockSerializer** only serializes the id, weight, and name fields. If you add user and type in the list of fields...

```py
class RockSerializer(serializers.ModelSerializer):
    """JSON serializer"""

    class Meta:
        model = Rock
        fields = ( 'id', 'name', 'weight', 'user', 'type', )
```

You only get the numeric foreign key value in the resulting JSON.

```json
{
    "id": 1,
    "name": "Angie",
    "weight": 3.6,
    "user": 1,
    "type": 5
}
```

The problem with this is that the client also wants to display the label field of the rock type in the browser. Note that the **displayRocks** function in the **RockList** component wants to access that value with `rock.type.label`.

```js
const displayRocks = () => {
    if (rocks && rocks.length) {
        return rocks.map(rock => <div>
            {rock.name} ({rock.type.label})
        </div>)
    }

    return <h3>Loading Rocks...</h3>
}
```

Therefore, the API sending back the integer of `5` in this case is not giving the client code what it needs.

## Serializer for Foreign Keys

To accomplish this for the client, you need to tell Django to not provide the integer value, but to read from the **Type** table and serialize the related data as a nested object.

Make sure you import the **Type** model at the top of the view.

```py
class RockTypeSerializer(serializers.ModelSerializer):
    """JSON serializer"""

    class Meta:
        model = Type
        fields = ( 'label', )
```

And then explicitly tell the **RockSerializer** to use that new one.


```py
class RockSerializer(serializers.ModelSerializer):
    """JSON serializer"""

    type = RockTypeSerializer(many=False)

    class Meta:
        model = Rock
        fields = ( 'id', 'name', 'weight', 'user', 'type', )
```

This will generate a JSON string representation for a rock that looks like this.

```json
{
    "id": 1,
    "name": "Angie",
    "weight": 3.6,
    "user": 1,
    "type": {
        "label": "Basalt"
    }
}
```

Now the client will get exactly the data that it needs.

## Full Stack Work

Now it's time for you to do a bit of full-stack web development. Look at the image below and you will notice that a few things have been added to both the API and the React client code. This is the **All Rocks** view being displayed.

- The weight of the rock is now displayed
- The first and last name of the rock owner is now displayed

![rock list with weight and owner name displayed](./images/augmented-rock-list.png)

Use your new knowledge of serializing foreign key fields on a model to return the first and last name of the user for each rock. Also make sure that the weight of the rock is serialized in the JSON string in the API, and then update the JSX of the client to display it.

Take special care to note that the initial state for the `rocksState` variable will likely need to be augmented to prevent React from throwing angry errors at you.

## Video Walkthrough

Here is a 4:15 minute walkthrough of implementing the code with explanations.

[<img src="./images/video-play-icon.gif" height="75rem" />](https://watch.screencastify.com/v/gWiYg6hTGxgMorSvnU5D)
