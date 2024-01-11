# Step 2: Local Environment File

The settings you created in the last step read from your operating system's [environment variables](https://medium.com/chingu/an-introduction-to-environment-variables-and-how-to-use-them-f602f66d15fa). To establish these environment variables for your Python virtual environment, follow these steps.

1. Create a `.env` file in your project directory.
2. Add the following content to the file.
   ```txt
   DJANGO_SECRET_KEY=keep_this_a_secret
   DEBUG=True
   DJANGO_ALLOWED_HOSTS='127.0.0.1,localhost'
   DEVELOPMENT_MODE=True
   ```
3. Update the `keep_this_a_secret` text with a UUID. You can generate one at the [Online UUID Generator](https://www.uuidgenerator.net/) site. Choose a version 4 UUID.

[Go to Step 3 >](./DEPLOY_DJANGO_03.md)