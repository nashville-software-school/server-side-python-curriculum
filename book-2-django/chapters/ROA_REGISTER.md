# Registering with the API

## Starting the Server in Debug Mode

Use the `Shift+Alt+D` keyboard shortcut to start your new API server in debug mode. When you do, you will see a new terminal window appear at the bottom of VS Code that looks like this once the API is started.

```txt
System check identified no issues (0 silenced).
October 01, 2023 - 04:21:36
Django version 4.2.5, using settings 'rockproject.settings'
Starting development server at http://127.0.0.1:8000/
Quit the server with CONTROL-C.
```

## Testing with API Client

### Register

Now you can test that the `/register` route works correctly.

1. Open your API client.
2. Create a new request.
3. Change method to POST.
4. Enter in `http://localhost:8000/register` for the URL.
5. Click the _Body_ tab under the URL. Make sure the content type **json** is chosen from the dropdown.
6. Paste JSON like the following into the body. Change the values to be you, or even something silly. Doesn't really matter.
    ```json
    {
        "email": "name@domain.com",
        "first_name": "MyFirstName",
        "last_name": "MyLastName",
        "password": "django"
    }
    ```
7. Click the _Send_ button.
8. You should get a response that has the Django authorization token that looks like this. Yours will be different.
    ```json
    {
        "token": "382676acef1f23f321d4821c91cc4e66"
    }
    ```

### Login

Next, test that the `/login` route works correctly.

1. Open your API client.
2. Create a new request.
3. Change method to POST.
4. Enter in `http://localhost:8000/login` for the URL.
5. Click the _Body_ tab under the URL. Make sure the content type **json** is chosen from the dropdown.
6. Paste JSON like the following into the body. Change the values to what you used during registration.
    ```json
    {
        "username": "name@domain.com",
        "password": "django"
    }
    ```
7. Click the _Send_ button.
8. You should get a response that  looks like this.
   ```json
   {
      "valid": true,
      "token": "3d354a1db7990c5c6eadffd9cfdbb669b6ca27d8"
   }
   ```
