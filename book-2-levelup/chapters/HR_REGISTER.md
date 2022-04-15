# Registering with the API

## Starting the Server in Debug Mode

Use the `Shift+Alt+D` keyboard shortcut to start your new API server in debug mode. When you do, you will see a new terminal window appear at the bottom of VS Code that looks like this once the API is started.

<img src="./images/hr-server-debug-startup.png" alt="Image of API running in debug mode in Visual Studio Code" width="800px" />

## Testing with API Client

Now you can test that the `/register` route works correctly.

1. Open Thunder Client extension _(or Postman if you switched to that)_.
1. Create a new request.
1. Change method to POST.
1. Enter in `http://localhost:8000/register` for the URL.
1. Click the _Body_ tab under the URL.
1. Paste JSON like the following into the body. Change the values to be you, or even something silly. Doesn't really matter.
    ```json
    {
        "email": "name@domain.com",
        "first_name": "MyFirstName",
        "last_name": "MyLastName",
        "password": "django",
        "address": "404 Unknown Route"
    }
    ```
1. Click the _Send_ button.
1. You should get a response that has the Django authorization token that looks like this. Yours will be different.
    ```json
    {
        "token": "382676acef1f23f321d4821c91cc4e66"
    }
    ````

> This token is unique for every user, and is used by Django to determine who the user is.

<img src="./images/honey-rae-registration-thunder-client.gif" alt="Animaation of testing registration API route with Thunder Client" width="800px" />

## Authenticating a User

Now you can test this out as an actual Honey Rae's customer who would be using the application.

1. Start up the Honey Rae's React application
1. Try to log in with the account that was created in the previous step.

> Username is `Carrie1945`

> Password is `me`

Verify that you can log in and that the logout link takes you back to the log in screen.

![](./images/initial-client-auth.gif)
