# Filtering By Multiple Conditions

In this explorer chapter, you will figure out how to use the Django ORM to filter tickets by more than one criteria.

Add the following 2 buttons to your **`TicketList`** component in the client.

```html
<button onClick={() => filterTickets("unclaimed")}>Show Unclaimed</button>
<button onClick={() => filterTickets("inprogress")}>Show In Progress</button>
```

## Multiple Filters

When using the Django ORM, you have already seen how to filter with one condition.

```py
service_tickets = ServiceTicket.objects.filter(date_completed__isnull=False)
```
The `date_completed__isnull=False` serves the purpose of a `WHERE` clause in a SQL statment to only select rows that pass a certain condition. In SQL, it would look like this.

```SQL
WHERE t.date_completed != NULL
```

If you want to have more filters, you just separate them with commas. Imagine you have an animals table and want to find only the ones that are exactly 3 years old, and are brown.

```py
animals = Animal.objects.filter(age=3, color='brown')
```

This will translate into the following `WHERE` clause.

```sql
WHERE a.age = 3
AND a.color = 'brown`
```

## Filter Unclaimed and In-Progress Tickets

You need to update your ticket view to check for two, new possible values of the `status` query string parameter. For the filtering, you will need to check the value of two columns, not just one.

Try it out and ask for help if you get stuck.
