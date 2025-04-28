# Step 5: Production Environment Variables

Next, you need to define the environment variables you declared in your project’s settings. For your Django app to function, you need to set the following environment variables.

1. Click the **Edit** link in the **Environment Variables** section.
2. Click the **Add from .env** choice, and a dialog box will appear.
3. Open your `.env` file that you created in the previous step and copy/pasta the contents into the dialog.
4. Change **DEBUG** to `False`.
5. Change **DEVELOPMENT_MODE** to `False`.
6. Change **ALLOWED_HOSTS** to include the URL for your deployed client _(e.g. `'127.0.0.1,localhost,www.awesomeapi.com')_
7. Add the following key/values.
    ```txt
    DJANGO_ALLOWED_HOSTS=${APP_DOMAIN}
    DISABLE_COLLECTSTATIC=1
    ```

8. Click **Save**.
9. Click the **Close** link for that section to save changes.

[Go to Step 6 >](./DEPLOY_DJANGO_06.md)
