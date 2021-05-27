### Move Database to workspace via Windows File Explorer

1. Open file explorer and navigate to your downloads folder.
1. Find the `Chinook_Sqlite.sqlite` file in your downloads folder, right click and copy the file. ![copy file](./images/copy_chinook_sqlite.png)
1. Next, in the input field in your file explorer, you will want to type `\\wsl$\Ubuntu...` You file explorer will give you options. Chose the path for the Ubuntu version you are currently using. If you only have one option, choose that one. ![navigatewsl](./images/file_explorer_wsl_ubuntu.png) 
1. Next, navigate to the `chinook` directory that you made inside of your `workspace` directory. For most of you this will be `users` > `<username>` > `workspace` > `chinook`. Once you've successfully navigated to your chinook directory, you can paste the `sqlite` file. ![pastesqlite](./images/paste_chinook_sqlite.png)
1. Click [here](./CHINOOK.md#instructions) to return to Book 3, chapter 1.