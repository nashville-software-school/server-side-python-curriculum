# Changing Your Database

Yeah, that was a lot of steps just to be able to change your database structure to store appointments. However, you've arrived at the crucial moment.

## 1. Initialize the Migration

The first step is to tell Django that you're ready to change your database. Use the following command to tell Django to begin the process of migration on the `deshawnapi` project.

```sh
python3 manage.py makemigrations deshawnapi
```

You will get the following output. It creates a file that has all of the instructions that will be run to make the changes to your database. Notice that it automatically identified that a new model named `Appointment` was added to the project. This means that it will add a new table named `deshawnapi_appointment` to your database.

```sh
Migrations for 'deshawnapi':
  deshawnapi/migrations/0002_appointment.py
    - Create model Appointment
```

## 2. Begin the Migration

Now you tell Django to run the instructions that it created to make the change to your database.

```sh
python3 manage.py migrate
```

You will see the following output.

```sh
Operations to perform:
  Apply all migrations: admin, auth, authtoken, contenttypes, deshawnapi, sessions
Running migrations:
  Applying deshawnapi.0002_appointment... OK
```

At this point, you can go look at your database and see that there is a new table added.

## 3. Add Data to Your DB using Postman
In Postman, run a POST to `` with the following payload:

```json
{
    "walkerId": 3,
    "appointmentDate": "2023-05-05",
    "completed": false
}
```
Now, create several more entries and check your database to see them.

## 4. Test your endpoints in Postman
Create Requests in Postman for the following routes:

|Request Method|URL|View Method Executed|
|--|--|--|
|GET|http://localhost:8000/appointments/1|retrieve|
|GET|http://localhost:8000/appointments|list|
|POST|http://localhost:8000/appointments|create|

# 🎉🎉🎉🎉 YOU DID IT!

