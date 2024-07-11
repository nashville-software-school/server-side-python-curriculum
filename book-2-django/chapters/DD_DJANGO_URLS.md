# Defining a Supported URL

The last step needed before you can run your migration to add the `deshawnapi_appointment` table to your database is to define the URL that clients can use to make GET and POST requests.

## URLs and DefaultRouter

The `DefaultRouter` class is incredibly powerful. The downside to powerful tools is that they are often highly abstract and mysterious to beginners. This is one of those cases.

Open your `urls.py` module and you will see the following code, as well as other code. The relevant code is shown below.

```py
from deshawnapi.views import WalkerView, CityView, DogView

router = routers.DefaultRouter(trailing_slash=False)
router.register(r'walkers', WalkerView, 'walk')
router.register(r'cities', CityView, 'city')
router.register(r'dogs', DogView, 'dog')
```

Your API only supports requests to `/walkers`, `/cities`, and `/dogs`. Any client requests to `/appointments`, or `/turtles` or any other path will be told that the resource doesn't exist and get a 404 status code.

To activate your new URL, do the following steps.

1. Add `AppointmentView` to the list of imports from the views package.
2. Register a new route with the default router.
    ```py
    router.register(r'appointments', AppointmentView, 'appointment')
    ```

The first argument is what you want your URL path to be. The second argument is the view that will handle client requests to that route. The third argument is needed in order for a route to be registered, but it is unused in our API and will not be covered or discussed.


## Next Steps

You are now ready to perform your first database migration. In the next chapter, you will learn about the commands to run in your terminal to perform one.
