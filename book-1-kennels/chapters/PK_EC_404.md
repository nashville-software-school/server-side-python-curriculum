# Handling Requests for Nonexistent Resource

Open your `request_handler` module and go to the `do_GET` function. You'll notice that at the beginning of the function you set a specific response status code of 200.

```py
self._set_headers(200)
```

Now, go to your API client and request animal 285.

<img src="./images/PK_EC_404.gif" width="700px" alt="Animation showing response of request to get animal 285" />

You will get a response with a status code of 200 even though there is no animal with an id of 285. That is not a valid response code. The client asked for a nonexistent resource. In this situation, the proper response code is **404 - Not Found**.


<img src="./images/PK_EC_404_EXISTS.gif" width="700px" alt="Animation showing response of request to get animal 285" />

## Algorithm

Here is the algorithm to follow. It is up to you to figure out how to implement each step using your researching skills.

1. What are the two possible returned data types when you invoke the function to get a single animal from the list?
1. After the function is invoked, check if it returned the Python version of null.
1. If an animal was found set the correct status code.
1. If an animal was not found set the correct status code.
1. If you want to be fancy, set a custom message to send back to the client if an animal was not found _(see animation above)_.

## Some Code for the Desperate

Ok, so if you **REALLY** want to make this work, but you are completely stumped, here's some code to get you started.


<details>
    <summary>Can't believe you gave up so easily</summary>

```py
response = get_single_animal(id)

if response is not None:
```

Want a custom response body?

```py
response = { "message": f"Animal {id} is out playing right now" }
```
</details>