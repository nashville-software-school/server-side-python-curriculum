# Bangazon Employee Handbook

## Support & Guidance

### Mentoring

Your manager is dedicated to providing all the mentoring and guidance that you need while you build the Bangazon Platform. This includes training you on foundational concepts, tooling and procedures. Your manager will also provide you will instruction to show you how to implement basic examples of code that you will need for a larger project.

### Daily Stand Up

Every morning, your manager will attend a 15 minute meeting with your entire team so that you may discuss progress that you are making, provide guidance on what you plan to complete in the next 24 hours, and raise concerns about any obstacles that you are encountering.

Your manager is responsible for making sure you have the resources that you need to complete the work, and it also responsible for removing any obstacles in your way.

### Retrospective

Once your team completes a project (see Definition of Done below), your team, along with your manager, will conduct a [Retrospective](https://www.mountaingoatsoftware.com/agile/scrum/sprint-retrospective). Be sure to read the description of the retrospective before attending your first one.

## Expectations of Work

### Definition of Done

There is a very clear [Definition of Done](https://www.agilealliance.org/glossary/definition-of-done/) that you must adhere to. If you do not, your manager will not approve the project for deployment.

1. The project must be fully documented. This includes the following:
    1. Complete README that documents the steps to install the code, how to install any dependencies, or system configuration needed.
    2. Every class must be documented with purpose, author, and methods.
    3. Every method must be documented with purpose and argument list - which itself must contain a short purpose for each argument.
1. The project must be able to run fully, and without errors, on each teammate's system.
1. Fulfills every requirement.
1. Every line of code has been peer reviewed.
1. For projects that require unit testing, core functionality must be identified and have at least one test for each.

### Pull Requests

When you submit a pull request to the project repository, it should provide all of the information necessary for one of your teammates to verify its completeness.

#### Descriptions

The description that you provide should be comprehensive enough to...

1. Provide clarity to any potentially complex code.
1. Explain reasons behind organizational or architectual decisions you made.
1. Give context to what feature you were completing so that your teammate has a mental model before looking at the code.

#### Steps to Test

You must provide clear steps for any teammate to test the code.

1. System configuration.
1. 3rd party libraries that need to be installed.
1. Command line utilities to run.
1. If there is a UI component, give clear instructions for steps to perform in the UI, and what they should expect to see as the outcome of those steps.

#### Link to Feature Ticket

At the end of the PR description, you must provide a hyperlink to the ticket that contains a description of the feature you are working on.

## Coding Standards

We will be following the [Python Community's coding guidelines](https://www.python.org/dev/peps/pep-0008/). Here are the big tickets items. Please read the style guide for more information.

1. Variable names are all lower case, with words seperated by underscores

    ```
    ThisIsBadPractice = False;
    this_is_good_practice = True;
    ```
2. All classes and methods will be documented with docstrings.
3. Four **spaces** for indentation.
4. Surround top-level function and class definitions with two blank lines. Method definitions inside a class are surrounded by a single blank line.
    ```
    import random


    def Bar():
        """Top level function"""


    class Foo:
        """Sample Foo class that does nothing"""

        def __init__(self):
            """Constructor function for Foo class"""
            bar = False
    ```
5. Import statements on seperate lines.


