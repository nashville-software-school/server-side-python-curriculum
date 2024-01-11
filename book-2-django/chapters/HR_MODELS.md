# A Database Model

Time to create a new ERD for the Honey Rae's Repairs application. This application allows customers to create service tickets for the team at Honey Rae's to work on over time. After a ticket is submitted, an employee can then access the application whenever she wants and assign herself to a ticket.

The **User** table is colored differently because you won't be creating it yourself. Django creates it for you. More on that later.

Create this ERD in your database diagramming tool of choice _(dbdiagram, DrawSQL, etc...)_. If you are using dbdiagram, we provide the syntax below.

<details>
<summary>Expand to get dbdiagram definitions</summary>

```txt
Table User {
  id int pk
  first_name varchar
  last_name varchar
  email varchar
}

Table Customer {
  id int pk
  address varchar
  user_id int [ref: > User.id]
}

Table Employee {
  id int pk
  specialty varchar
  user_id int [ref: > User.id]
}

Table ServiceTicket {
  id int pk
  customer_id int [ref: > Customer.id]
  employee_id int [ref: > Employee.id]
  description varchar
  emergency boolean
  date_completed date
}
```
</details>

![](./images/honey-rae-api-django.png)


## Django Models

It's important to note at this point that there is additional information that needs to be captured about the two types of users in this API.

1. We need to capture the **address** for a customer, but the Django user table doesn't have an address field.
2. We need to capture the **specialty** for an employee, but the Django user table doesn't have an specialty field.
3. The **specialty** field isn't relevant for a customer.
4. The **address** field isn't relevant for an employee.

When an employee logs in, data from the **User** table and data from the **Employee** table work together to represent that single user.

When a customer logs in, data from the **User** table and data from the **Customer** table work together to represent that single user.

Since data from **User/Customer** or **User/Employee** represents a single user, the relationship between them is **One To One** and not one to many.

### Customer Model

Make the file below and copy pasta the code into it. This is the model that you will interact with, and it has a 1-1 relationship with the user model that lives inside Django.

> #### `repairsapi/models/customer.py`

```py
from django.db import models
from django.contrib.auth.models import User


class Customer(models.Model):

    # Relationship to the built-in User model which has name and email
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    # Additional address field to capture from the client
    address = models.CharField(max_length=155)

    @property
    def full_name(self):
        return f'{self.user.first_name} {self.user.last_name}'
```

Now that you have a model defined, it needs to be added to your project's models package.

### Employee Model

Make the file below and copy pasta the code into it.

> #### `repairsapi/models/employee.py`

```py
from django.db import models
from django.contrib.auth.models import User


class Employee(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    specialty = models.CharField(max_length=155)

    @property
    def full_name(self):
        return f'{self.user.first_name} {self.user.last_name}'
```

Now that you have an employee model defined, it needs to be added to your project's models package.

### ServiceTicket Model

Make a `service_ticket.py` module and define a **ServiceTicket** model in it. Meet the requirements set in the ERD above 👆🏿.

1. Foreign key to Customer
2. Foreign key to Employee. Allow this foreign key to be blank and null since an employee is not assigned to a ticket on creation.
3. Description
4. Emergency
5. Date completed. Allow this value to be blank and null as well since it won't have a value on creation.

Make sure you add it to the models package when done.

## Migration of Models

Once you are done defining your models, make a migration and then run the migration. You should now have a `db.sqlite3` file in the project folder.
## Resources

* [Django Models](https://docs.djangoproject.com/en/3.2/topics/db/models/) - Overview of Django Models
* [null and blank values for fields](https://docs.djangoproject.com/en/4.2/ref/models/fields/#null) - What **null** and **blank** mean
* [One to One Relationships](https://docs.djangoproject.com/en/3.2/topics/db/models/#one-to-one-relationships) - How to set up a Many-Many Relationship
* [One to Many Relationships](https://docs.djangoproject.com/en/3.2/topics/db/models/#many-to-one-relationships) - How to add a foreign key to a model
