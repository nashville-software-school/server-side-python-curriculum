## Github Actions for Building &amp; Deploying React Applications

Building and deploying your React application to Github Pages is a bit more time consuming to setup, but it's not awful.

First, you are going to configure your project to enable automated building and deploying

## Configuring For Deployment

Inside the `vite.config.js` file, add the `base` property seen deploy to the configuration to ensure that your React app is deployed correctly:

```js
export default defineConfig({
  base: "/<repository-name>/", // add repository name here
  plugins: [react()],
})
```

## Automating Deployment with GitHub Actions

This only allows you to manually trigger deploys from your local machine. That's _**not**_ what the goal is. You want a deployment to happen every time a branch is merged to `main`.

1. Switch to a new branch, or `develop`
2. Create a new directory named `.github/workflows` in the root of your repository.
3. Inside the `.github/workflows` directory, create a new file named `deploy.yml`.
4. Add the following workflow configuration to the `deploy.yml` file:
   ```yml
   # Simple workflow for deploying static content to GitHub Pages
   name: Deploy static content to Pages

   on:
     # Runs on pushes targeting the default branch
     push:
       branches: ['main']

     # Allows you to run this workflow manually from the Actions tab
     workflow_dispatch:

   # Sets the GITHUB_TOKEN permissions to allow deployment to GitHub Pages
   permissions:
     contents: read
     pages: write
     id-token: write

   # Allow one concurrent deployment
   concurrency:
     group: 'pages'
     cancel-in-progress: true

   jobs:
     # Single deploy job since we're just deploying
     deploy:
       environment:
         name: github-pages
         url: ${{ steps.deployment.outputs.page_url }}
       runs-on: ubuntu-latest
       steps:
         - name: Checkout
           uses: actions/checkout@v4
         - name: Set up Node
           uses: actions/setup-node@v4
           with:
             node-version: 20
             cache: 'npm'
         - name: Install dependencies
           run: npm ci
         - name: Build
           run: npm run build
         - name: Setup Pages
           uses: actions/configure-pages@v4
         - name: Upload artifact
           uses: actions/upload-pages-artifact@v3
           with:
             # Upload dist folder
             path: './dist'
         - name: Deploy to GitHub Pages
           id: deployment
           uses: actions/deploy-pages@v4
    ```
5. Commit and push the branch to your repository.

GitHub Actions will now automatically build and deploy your React app to GitHub Pages whenever you push changes to the main branch. You can monitor the workflow's progress directly within your GitHub repository under the **Actions** tab.

## (Optional) Read-write permissions

If you encounter any issues with the deployment process due to read-write permissions, you can update the permissions of the workflow secret by following these steps:

1. Navigate to your GitHub repository settings.
2. Under **Actions** -> **General** tab, enable the _Read and write_ permissions in the **Workflow permissions** section.
3. Click **Save changes** to update the permissions and re-run the workflow.