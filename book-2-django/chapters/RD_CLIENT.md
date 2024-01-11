# Reader's Digest Client

Time to build a React client to interact with your Reader's Digest API.

## Start React Project With Vite

If you just want to set up a blank React project, but not use Tailwind, follow these steps.

1. Make a new directory in **workspace** for the application.
2. In that new directory, create a React app template
    ```sh
    npm create vite@latest . -- --template react
    ```
3. Open in VS Code
4. `npm run dev` to start the development server

## Optionally Use Tailwind

If you want to use Tailwind, follow these additional steps, otherwise skip them. If you already started the dev server, you can stop it, or just open a new terminal and run these commands.

1. `npm install -D tailwindcss postcss autoprefixer`
2. `npx tailwindcss init -p`
3. Replace the contents of `tailwind.config.js` with the following.
   ```js
   /** @type {import('tailwindcss').Config} */
   export default {
     content: [
       "./index.html",
       "./src/**/*.{js,ts,jsx,tsx}",
     ],
     theme: {
       extend: {},
     },
     plugins: [],
   }
   ```
4. Replace the contents of `index.css`
   ```css
   @tailwind base;
   @tailwind components;
   @tailwind utilities;
   ```

## Rock of Ages UI

Here's what users should be able to do.

1. Register a new account
2. Login to an existing account
3. Create a book with 1-_n_ categories assigned
4. View all books
5. View individual book, with all reviews listed
6. Create a new review when viewing an individual book

## Video Walkthrough For Checkboxes

Django makes handling many-to-many relationships pretty easy with using the **set()** method.

```py
book.categories.set(category_ids)
```

However, beginners tend to have a harder time generating the array of primary keys in the client! Therefore, here's a **Readers Digest - Category Checkboxes** video that shows how to handle checkboxes in a form using the `Set()` data structure, and then converting it to an array before performing the POST operation.

The length of the video is 8:11.


[<img src="./images/video-play-icon.gif" height="75rem" />](https://watch.screencastify.com/v/wyxsjxSNbIjV4C6FEZOB)