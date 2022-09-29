# Simple Park Map Visualization


## Database Migration

Kennywood is largely a rectangular lot. The park managers have broken it up so that the areas are laid out like a grid, and each area has a designation like A2, or C1.

The letter determines the row of the park grid.

The number determine which column of the row.

| | | |
|--|--|--|
| A1 | A2 | A3 |
| B1 | B2 | B3 |
| C1 | C2 | C3 |


## Export Park Areas with `dumpdata`

The first step is to export the park area table data to a JSON file into a `fixtures/parkareas.json` file. Read the [Django dumpdata and loaddata](https://coderwall.com/p/mvsoyg/django-dumpdata-and-loaddata) article to see how to export a single table to a JSON file.

This gives you a snapshot of your data before you make changes to your model(s).

## Update Park Area Model

Add a new property to the **`ParkArea`** Django model named `zone`. It's value will be alphanumeric. It will have two characters. The first will be a letter. The second will be a number. Make sure you set [`default=""` attribute](https://docs.djangoproject.com/en/3.1/ref/models/fields/#default) on the new property.

Then migrate your database.

```sh
python3 manage.py makemigrations
python3 manage.py migrate
```

## Update Data

Now use your SQL skills and tools to connect to your database and run some `UPDATE` statements to give each park area a zone designation of your choosing.

## Park Map Link

Add a new link to your navigation bar labeled "Park Map". Make it change the browser route to `/map`.

## Park Map Component

Make a new UI component in your React application that visualizes all park areas in a grid layout. You can use Flexbox and other CSS properties to create the colors you want in this view.

| | |
|--|--|
| Water Park | Coaster Canyon |
| Kids Corner | Family Zone |
| Arcade | Reacetrack |
