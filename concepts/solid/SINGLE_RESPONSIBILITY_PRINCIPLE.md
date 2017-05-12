# Single Responsibility Principle

> There is one and only one reason to change a class. More specifically, this principle states that every module or class should have responsibility over a single part of the functionality. Think of your classes as Actors in your software, and what the responsibility of each is.

This means that we should start to think small. Each complex problem cannot easily be solved as a whole. It is much easier to first divide the problem in smaller sub-problems. Each sub-problem has a reduced complexity compared to the overall problem and can then be tackled separately.

## Impact on Code

1. Easier to understand
1. Less error prone
1. More robust
1. Easier to test
1. More maintainable and extendable

## Example

Consider this representation of a Patient.

```py
class Patient():

    def __init__(self, first_name, last_name, location):
        self.__first_name = first_name
        self.__last_name = last_name
        self.__location = location
        self.__ailments = set()
        self.__treatments = set()
        self.__hospitals = set()
        self.__hospitalized = False

    @property
    def name(self):
        return "{} {}".format(self.__first_name, self.__last_name)

    @property
    def location(self):
        return self.__location

    @location.setter
    def location(self, val):
        self.__location = val

    @property
    def ailments(self):
        return self.__ailments

    def add_ailment(self, ailment):
        return self.__ailments.add(ailment)

    def provide_treatment(self, ailment, treatment):
        self.__ailments.remove(ailment)
        self.__treatments.add(treatment)

    def admit_to_hospital(self, hospital):
        self.__hospitals.add(hospital)
        self.__hospitalized = True

    def discharge_from_hospital(self, hospital):
        self.__hospitalized = False
```

Would you consider this class to be complying with the Single Responsibility Principle? Is there only one reason for this class to change?

To answer this question, you must ask yourself what the purpose of the Patient class is. At the most basic, it is intended to be a representation of a person who needs medical care. It should also provide accessors (getters) and mutators (setters) to change its current state.

Given that initial intention, is the class definition above adhering to the SRP? Obviously not, since it's also performing operations involving admitting and discharging the patient from a hospital, something that a Patient is not responsible for. 

Who is responsible for that? That would be a Doctor.

What else is a Doctor responsible for? Perhaps diagnosing a patient with an ailment and providing treatments. How does a doctor record that information? Certainly not by tattooing it onto the patient, so having the Patient class store a collection of ailments and treatments violates the SRP as well.

Let's add some code to assign the proper responsibility to the proper actor in this scenario. We have two obvious actors - the Patient and the Doctor.

> **patient.py**

```py
class Patient():

    def __init__(self):
        self.__first_name = ""
        self.__last_name = ""
        self.__address = ""
        self.__chronic_ailments = set()

    def diagnose(self, ailment):
        self.__chronic_ailments.add(ailment)

    @property
    def name(self):
        return "{} {}".format(self.__first_name, self.__last_name)

    @name.setter
    def name(self, name):
        self.__first_name = name.split(",")[0]
        self.__last_name = name.split(",")[1]

    @property
    def address(self):
        return self.__address)

    @address.setter
    def address(self, address):
        self.__address = address
```

> **doctor.py**

```py
class Doctor():

    def __init__(self):
        self.__first_name = None
        self.__last_name = None
        self.__office = None

    @property
    def name(self):
        return "{} {}".format(self.__first_name, self.__last_name)

    @name.setter
    def name(self, name):
        self.__first_name = name.split(",")[0]
        self.__last_name = name.split(",")[1]

    @property
    def office(self):
        return self.__office_location

    @office.setter
    def office(self, loc):
        self.__office_location = loc
```

This is a good start. Some basic properties are defined for each actor and they can be retrieved and modified. You'll notice that I modifed the `Patient` class to only retain a set of chronic illnesses since those are long-term, or permanent state modifications of a doctor's patient.

Ok, time to start adding responsibilities to the doctor.

```py
def diagnose_patient(self):
    ...
```

So... what do I do here? I need a patient to diagnose.

```py
def diagnose_patient(self, patient):
    ...
```

Then I need the ailment to assign to the patient.

```py
def diagnose_patient(self, patient, ailment):
    # There is a method on every Patient instance
    # that a Doctor can use to diagnose the patient
    # with a chronic illness
    patient.diagnose(ailment)
```

Now, a sample set of implementation logic.

```py
thomas = Patient()
thomas.name = "Thomas Buida"

rachel = Doctor()
rachel.name = "Rachel Werner"
rachel.office = "100 Fallopian Way"

rachel.diagnose_patient(thomas, "Tuberculosis")
```

Now we have the appropriate actor diagnosing a patient.

Next, we need to address the `admit_to_hospital`, and `discharge_from_hospital` methods that were on the original `Patient` class. What actor would be responsible for those actions?

Right, a doctor also does that. Since the set of hospitals no longer is maintained in the state of the `Patient` class, how would we admit a patient to one?

I think we now need a `Hospital` class.

```py
class Hospital():

    @property
    def address(self):
        return self.__address

    @office.setter
    def office(self, address):
        self.__address = address
```

Do you remember the term for relating individual actors to each other without creating a dependent relationship? Right, it's aggregation.

```py
class Hospital():

    def __init__(self):
        # Initialize a set to hold people admitted to the hospital
        self.__admitted_patients = set()

    # Define a method to admit a person
    def admit(self, patient, doctor):
        admitted_patient = dict()
        admitted_patient["patient"] = patient
        admitted_patient["attending_physician"] = doctor
        self.__admitted_patients.add(admitted_patient)

    # Define a method to discharge a person
    def discharge(self, patient):
        for resident in self.__admitted_patients:
            if resident.patient is patient:
                self.__admitted_patients.remove(patient)

    @property
    def address(self):
        return self.__address

    @office.setter
    def address(self, address):
        self.__address = address
```

Now we can add the responsibility to the doctor.

```py
class Doctor():

    ...

    # Admit patient to hopital by agreeing to be the attending physician
    def admit_patient(self, patient, hospital):
        hospital.admit(patient, self)

    # Discharge a patient from the hospital
    def discharge_patient(self, patient, hospital):
        hospital.discharge(patient)
```

See if you can think of other actors involved in the process of routine health care: visiting a primary physician, making an appoinment, filling prescriptions for treatment, etc. Using the SRP, define the responsibilities of each actor and how the relationships between each one could be defined.