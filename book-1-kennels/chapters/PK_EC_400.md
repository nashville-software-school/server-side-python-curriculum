# Trust the Client, but Verify

Very often, the client code and the server code are maintained by two, disinct teams of developers. They are working towards a common goal, but the server code team doesn't have ownership over the client code, so they adopt the policy to validate all of the data that the client sent. If any of the data is invalid, a status of of 400 will be sent with the response, and a message stating why it was invalid.

## Missing Property

The server knows that the following properties are required for a new location object sent by the client.

1. name
1. address

Therefore, before the server code adds the request body to the list of locations, it verifies that they both exist.

Watch the following animation that first tries to send an invalid request with a missing address property. Then it send a second invalid object with a missing name property. In each case, the response has a 400 status code and a helpful message.

Finally, both properties exist in the request, and the new location is added and the response gets the 201 status code.


<img src="./images/PK_INVALID_REQUEST.gif" width="650px" alt="" />

## Research Tips

1. How do you check if a Python dictionary has a key?
1. Can you use ternary statements in a Python f-string?

## Invalid Animals

Verify all of the data, for all resources, that could be sent by the client to be put in the official list of dictionaries. If any property is missing from any resource, send a 400 status code and a message in the response.

#### Do You Give Up?

Let your failure to research Python code on the Web be an inspiration for future generations.

<details>
    <summary>Disappointment Code</summary>

Even this code is not 100% of what you need, but it's most of it. Oh, and it also has a syntax error in it that you need to fix for it to work.

```py
if "name" in post_body and "address" in post_body:
    self._set_headers(201)
    created_resource = create_location(post_body)
else:
    self._set_headers(400)
    created_resource = {
        "message": f'{"name is required" if "name" not post_body else ""} {"address is required" if "address" not post_body else ""}'
    }
```
</details>