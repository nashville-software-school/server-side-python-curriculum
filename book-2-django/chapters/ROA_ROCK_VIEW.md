# Support GET and POST for Rocks

For the **Rock** view, you initially need to support the following request types.

| Method | URL | Response Data | Status Code |
|--|--|--|--|
| GET | http://localhost:8000/rocks | List of all rocks | 200 |
| POST | http://localhost:8000/rocks | New rock object | 201 |


In this chapter, we are only going to implement the code to support the GET operation. The POST operation is handled by the `create` method, but that will be implemented fully in a future chapter.

Create a new view module for rocks and put the following code in it.


```py
from django.http import HttpResponseServerError
from rest_framework import serializers, status
from rest_framework.response import Response
from rest_framework.viewsets import ViewSet
from rockapi.models import Rock


class RockView(ViewSet):
    """Rock view set"""


    def create(self, request):
        """Handle POST operations

        Returns:
            Response -- JSON serialized instance
        """

        # You will implement this feature in a future chapter
        return Response("", status=status.HTTP_405_METHOD_NOT_ALLOWED)

    def list(self, request):
        """Handle GET requests for all items

        Returns:
            Response -- JSON serialized array
        """
        try:
            rocks = Rock.objects.all()
            serializer = RockSerializer(rocks, many=True)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except Exception as ex:
            return HttpResponseServerError(ex)


class RockSerializer(serializers.ModelSerializer):
    """JSON serializer"""

    class Meta:
        model = Rock
        fields = ( 'id', 'name', 'weight', )

```

## Register Your Route

1. Import the rock view into the **views** package
2. Import that view into `urls.py`
3. Register that view to handle requests to http://localhost:8000/rocks
    ```py
    router.register(r'rocks', RockView, 'rock')
    ```
4. Perform a GET request and verify that you get an empty list back with a 200 status code.

## Client Keys and Server Keys

You need to take a moment to reflect on an important aspect of full-stack development that oft confuses beginners - the differentiation of the field names on a model and the key names sent by the client request.

Focus on the following block of code.

```py
rock.user = request.auth.user
rock.weight = request.data["weight"]
rock.name = request.data["name"]
rock.type = request.data["typeId"]
```

The fields on the model are user, weight, name, and type. However, when the client sends a POST request, here's what the body _(or payload)_ of the request has in it.

```json
{
	"name": "Errol",
	"weight": 0.95,
	"typeId": 3
}
```

Note that the `name` and `weight` keys on this request payload match the field names for the model, but `typeId` does not.

**It doesn't have to**

The client can send whatever keys it wants in the request. You just have to access the correct key on `request.data` and assign the value of that key to the corresponding field on the model.

## Authentication

You also need to remember that you don't specify anything about the user in the request payload. The client sends the **Authorization** header on each request...

```js
fetch("http://localhost:8000/rocks", {
	headers: {
		"Authorization": "Token u9t8u4t893v8thb9ht29uhv2"
	}
})
```

It is that header that tells the server who is authenticated in the client. You can then use the `request.auth.user` anywhere in the Python code to access the information about that user.

Again, in the same code block, notice the use of `request.auth.user` being assigned to the `user` field of the rock. You get that for free with Django.

```py
rock.user = request.auth.user
rock.weight = request.data["weight"]
rock.name = request.data["name"]
rock.type = request.data["typeId"]
```
