# Expanded Animal Response

> 🧨 Before you start working on Explorer and Pioneer chapters, create a new branch labeled "explorer" for your two projects. This will allow you to re-use the existing code when you get to Book 2.

Currently, if you request an animal, you get a JSON response in this form.

```json
{
    "name": "Falafel",
    "species": "Cat",
    "locationId": 2,
    "customerId": 1
}
```

If you wanted the location name and the customer name, you would need to make 2 additional requests.

1. http://localhost:8088/locations/1
1. http://localhost:8088/customers/3

If this is a common need of the client - to want the location and customer name for an animal - then the server code should be augmented so that the client only needs to make one request to get all that information.

```json
{
    "name": "Falafel",
    "species": "Cat",
    "location": {
        "id": 2,
        "name": "Nashville South",
        "address": "209 Emory Drive"
    },
    "customer": {
        "id": 1,
        "name": "Ryan Tanay"
    }
}
```

## Request Handlers Using Other Handlers

Open your `views/animal_requests.py` module and go to the `get_single_animal` function. You need to augment this function make the `requested_animal` dictionary more robust.

What is needed?

1. You need to get a single location
1. You need to get a single customer

Can you figure out what needs to be imported into the `animal_requests.py` module?

<details>
    <summary>Hint: Imports needed</summary>

Having the dot at the beginning is important because the other modules are in the same directory, and that's how you tell Python where to look for the module.

```py
from .location_requests import get_single_location
from .customer_requests import get_single_customer
```
</details>

## Augmenting the Dictionary

Remember that you need to use square brackets to add a key to a dictionary in Python. For example `animal["customer"] = something` to add a new `customer` key and value.

Can you invoke the imported methods to get the related resources for the animal and attach them to the dictionary you found?

<details>
    <summary>Hint: Attaching the location</summary>

```py
matching_location = get_single_location(requested_animal["locationId"])
requested_animal["location"] = matching_location
```
</details>

## Losing the Foreign Key

Now that the related location and customer dictionaries are embedded directly on the animal, there's no need to have the `locationId` and `customerId` keys on the dictionary any longer.

Use your Web searching skills to find out how to delete a key from a Python dictionary.
