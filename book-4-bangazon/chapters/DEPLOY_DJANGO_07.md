# Step 7: (Optional) Applying Fixtures

Each time you push your `main` branch up to Github, Digital Ocean will automatically build and deploy your API. This means that the database is created, from scratch, every time. This is fine while you are testing the deployment process, or are actively developing the features.

To prevent having an empty database every time you build and deploy, you can load your fixtures.

1. Go to **Settings** tab
2. Click the box for your API app
3. Scroll down to **Commands**
4. Click the **Edit** link
5. Go to the end of the `migrate` command and hit enter
6. Enter in as many `loaddata` commands as you need to seed your database

![](./images/adding-fixtures.gif)
