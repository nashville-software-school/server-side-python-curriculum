# Step 5: Production Environment Variables

Next, you need to define the environment variables you declared in your project’s settings. For your Django app to function, you need to set the following environment variables like so:

* `DJANGO_ALLOWED_HOSTS` -> `${APP_DOMAIN}`

    This allows the platform to know the randomly generated URL that App Platform provides and provide it to your app.

* `DEBUG` -> `True`

    Set this to **True** for now to verify your app is functioning and set to **False** later once everything is working.

* `DJANGO_SECRET_KEY` -> `<A RANDOM SECRET KEY>`

    Again, you can use the [Online UUID Generator](https://www.uuidgenerator.net/) to generate a random secret key. Don’t forget to click the Encrypt check box to ensure that your credentials are encrypted for safety.

* `DISABLE_COLLECSTATIC` -> `1`

Click **Save**.

Click **Next** until you reach the **Review** page.

[Go to Step 6 >](./DEPLOY_DJANGO_06.md)
