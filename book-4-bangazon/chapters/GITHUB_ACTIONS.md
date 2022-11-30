# Automating Build and Deploy of React App

You are going to set up your Github repository to serve the static, built version of your React app.

## Repo Configuration

1. Go to your Github repo.
2. Click on **Settings** tab.
3. Click on the **Pages** link on the left.
4. Under the **Build and Deployment** section, choose _Deploy from a branch_ option from the dropdown.
5. In the **Branch** dropdown that appears, choose `gh_pages`.
6. Click **Save**.

## Project Configuration

1. Make sure your are on the `main` branch of your project.
1. In your project directory, create a `.github/workflows` directory.
2. In the `workflows` directory, create a `deploy.yml` file.
3. Add the following content to the file.
   ```yml
   name: Build & deploy

   on:
     push:
       branches:
         - main
     pull_request:
       branches:
         - main

   jobs:
     build:
       name: Build
       runs-on: ubuntu-latest

       steps:
         - name: Checkout code
           uses: actions/checkout@v2

         - name: Install Node.js
           uses: actions/setup-node@v1
           with:
             node-version: 13.x

         - name: Install NPM packages
           run: npm install

         - name: Build project
           run: npm run build

         - name: Upload production-ready build files
           uses: actions/upload-artifact@v2
           with:
             name: production-files
             path: ./build

     deploy:
       name: Deploy
       needs: build
       runs-on: ubuntu-latest
       if: github.ref == 'refs/heads/main'

       steps:
         - name: Download artifact
           uses: actions/download-artifact@v2
           with:
             name: production-files
             path: ./build

         - name: Deploy to gh-pages
           uses: peaceiris/actions-gh-pages@v3
           with:
             github_token: ${{ secrets.GITHUB_TOKEN }}
             publish_dir: ./build
   ```
1. Open your `package.json` file in your project.
2. Replace the following line
    ```json
    "build": "react-scripts build",
    ```
    with
    ```json
    "build": "CI=false react-scripts build",
    ```
1. Add, commit, and push your main branch to your Github repo.

## Watching the Build

1. Go to your Github repo and click the **Actions** tab.
2. You will see a new process running named the same as your commit message. This process takes a minute or two.
3. When it's done, you will either see a red x - which means the build failed - or a green checkmark - which means the build succeeded and your project has been deployed.
4. If it succeeded, go back to the **Settings** > **Pages** screen and you will a link at the top that looks like this
    ```txt
    Your site is live at https://username.github.io/projectname/
    ```
1. Click on that link and view your deployed project.