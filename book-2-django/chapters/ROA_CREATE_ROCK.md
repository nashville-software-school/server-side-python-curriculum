# Creation of Rocks

The client application already has a form component for you. What you need to implement in the API is to capture the request from the client and insert the data into the database using the Django ORM magic.

Make sure that you import the **Type** model into the rock view module.


<details>
<summary>Expand to get your API create code</summary>

```py
    def create(self, request):
        """Handle POST requests for rocks

        Returns:
            Response: JSON serialized representation of newly created rock
        """

        # Get an object instance of a rock type
        chosen_type = Type.objects.get(pk=request.data['typeId'])

        # Create a rock object and assign it property values
        rock = Rock()
        rock.user = request.auth.user
        rock.weight = request.data['weight']
        rock.name = request.data['name']
        rock.type = chosen_type
        rock.save()

        serialized = RockSerializer(rock, many=False)

        return Response(serialized.data, status=status.HTTP_201_CREATED)
```
</details>

## Full Stack Work

Once you have implemented the create method in the API for rocks, go to the rock form in the React browser client. Fill out the form and see if a new rock is added to the database.

## Debugging the Client

If you've made it this far, you have noticed that there is something wrong with the client code. Submitting the rock form isn't doing what you expect.

- Look at your request payload in the Network tab when you submit the form.
- Watch the Components tab and inspect the state of the **RockForm** component as you fill out the form.
- Preview the response from the API when you submit the form and see if there are additional clues.

