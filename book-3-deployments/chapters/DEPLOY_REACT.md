# Digital Ocean Static App Deploy

First, if you haven't used Digital Ocean yet, [sign up for 60-day, $200 credit](https://m.do.co/c/47e5e578d1cd).

Deploying your first three static sites is cost free on Digital Ocean. Your React applicatons are considered to be static apps, so you won't be charged for them, unless you go over your 3 free static deployed apps.

## Deploy Static Application

1. In Digital Ocean, create a new application. Do not make this part of your API app.
2. Connect Digital Ocean to your Github account if you haven't yet.
3. Click the Github icon.
4. Choose your repository from the search field that appears.
5. Click **Next**.
6. It _should_ auto-detect that you're trying to deploy a **Static Site** and all of the defaults should be unchanged. 
    > Note: If you get a message that it could not find an app in your repo, type `/src` in the "Source directory" field and click "Find directory".
7. If it did not detect that your React app is static, follow these steps
    1. Click on the **Edit** button next to the web service.
    2. Click on the **Edit** link in the **Resource type** section
    3. Choose **Static Site** from the dropdown.
    4. Click **Save**.
7. Click next.
8. Type in an app name like "sinks-steve" or anything else that works.
9. Click next.
10. Make sure **Starter Plan** is chosen.
11. Click **Launch Starter App**.

Now wait for a few minutes while your application is built and deployed. Once successful, you can click on the link they provide and see your site!
