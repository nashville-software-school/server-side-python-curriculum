# Expanding Orders With SQL

Currently, your order JSON in a response to a client looks like this.

```json
{
    "id": 1,
    "timestamp": 1614659931693,
    "style_id": 3,
    "metal_id": 3,
    "size_id": 2
}
```

The goal is to have the related information expanded and embedded in the JSON so that the client doesn't have to perform multiple `fetch()` calls to get the metal, style, and size.

```json
{
    "id": 1,
    "timestamp": 1614659931693,
    "style_id": 3,
    "style": {
        "style": "Vintage",
        "price": 965
    },
    "metal_id": 3,
    "metal": {
        "metal": "24K Gold",
        "price": 1258.9
    },
    "size_id": 2,
    "size": {
        "carets": 0.75,
        "price": 782
    }
}
```

## Joining the Three Related Tables

You are going to practice the `JOIN` process in SQL for this solution.

Now you can join the `Metals` table into the query so that the `name` and `price` fields are in the results. Run the following SQL to see the additional information from the Metals table.

```sql
SELECT
    o.timestamp,
    o.size_id,
    o.style_id,
    o.metal_id,
    m.metal,
    m.price
FROM `Order` o
JOIN Metals m ON m.id = o.metal_id
```

#### SQL

Update the existing SQL in the `get_all_orders()` function to join in the 3 related tables, and select all required columns from those tables. Here's some SQL to get you started.

```sql
SELECT
    o.timestamp,
    o.size_id,
    o.style_id,
    o.metal_id,
    m.metal,
    m.price
    -- You select the rest of the columns from the joined tables here
FROM `Order` o
JOIN Metals m ON m.id = o.metal_id
-- You write the rest of the JOIN clauses here
```

## Creating Expanded Orders

Update your logic for creating an order to include the size, style, and metal. Here's some starter code.

```py
for row in dataset:

    # Create an order from the current row
    order = {
        'timestamp': row['timestamp'], 
        'metal_id': row['metal_id'], 
        'style_id': row['style_id'], 
        'size_id': row['size_id']
    }

    # Create a dictionary representation of the size from the current row

    # Create a dictionary representation of the style from the current row

    # Create a dictionary representation of the metal from the current row

    # Add the dictionary representation of related object to the order instance
    # Here what added the size would look like. You add the other two.
    order['size'] = size

    # Add the dictionary representation of the order to the list
    orders.append(order)
```