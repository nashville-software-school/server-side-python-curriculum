# Commonly Used Software Development Team Terms

The following list contains commonly used terms used by many software development teams. It is important that terms commonly used are understood by all the team members. A common understanding greatly enhances communication and makes it easier to on-board new team members. 

## Continous Integration
Continuous Integration (CI) is a development practice that requires developers to integrate code into a shared repository several times a day. Each check-in is then verified by an automated build, allowing teams to detect problems early.

By integrating regularly, you can detect errors quickly, and locate them more easily. https://www.thoughtworks.com/continuous-integration

## GitFlow
Vincent Driessen's branching model is a git branching and release management strategy that helps developers keep track of features,
hotfixes and releases in bigger software projects. It is a commonly used branching strategy, the diagrams make it look more difficult 
that it really is. It is vital the teams sharing code have a branching strategy. A branching strategy protects production code, and protects team
members from damaging the code base. http://jeffkreeftmeijer.com/2010/why-arent-you-using-git-flow/

## Coding Standards

The following is from this source https://msdn.microsoft.com/en-us/library/aa291591(v=vs.71).aspx. A comprehensive coding standard encompasses all aspects of code construction. While developers should prudently implement a standard, it should be adhered to whenever practical. Completed source code should reflect a harmonized style, as if a single developer wrote the code in one session. At the inception of a software project, establish a coding standard to ensure that all developers on the project are working in concert. When the software project incorporates existing source code, or when performing maintenance on an existing software system, the coding standard should state how to deal with the existing code base.

The readability of source code has a direct impact on how well a developer comprehends a software system. Code maintainability refers to how easily that software system can be changed to add new features, modify existing features, fix bugs, or improve performance. Although readability and maintainability are the result of many factors, one particular facet of software development upon which all developers have an influence is coding technique. The easiest method to ensure a team of developers will yield quality code is to establish a coding standard, which is then enforced at routine code reviews.

Using solid coding techniques and good programming practices to create high-quality code plays an important role in software quality and performance. In addition, if you consistently apply a well-defined coding standard, apply proper coding techniques, and subsequently hold routine code reviews, a software project is more likely to yield a software system that is easy to comprehend and maintain.

## Code Reviews
Everyone at Bangazon will review code and have their code reviewed. It is important that coding standards are followed so code reviews can be most productive.Although the primary purpose for conducting code reviews throughout the development life cycle is to identify defects in the code, the reviews can also enforce coding standards in a uniform manner. Adherence to a coding standard is only feasible when followed throughout the software project from inception to completion. It is not practical, nor is it prudent, to impose a coding standard after the fact. 

## TDD (Test Driven Development)
Test driven development (TDD) is an software development approach in which a test is written before writing the code. Once the new code passes the test, it is refactored to an acceptable standard.
TDD ensures that the source code is thoroughly unit tested and leads to modularized, flexible and extensible code. It focuses on writing only the code necessary to pass tests, making the design simple and clear.

## Daily Standup
Development teams at Bangazon Inc. will schedule daily standups where progress is discuss as well as road blocks. Team members will answer the following questions:
 * What did I accomplish yesterday?
 * What will I do today?
 * What obstacles are impeding my progress?
 * Daily standups are usually limited to 15 minutes. If it discovered more discussion is needed, attendees make arrangements to discuss in more detail after the meeting.

##Sprints
It is a short, consistent cycle no longer than four weeks. The goal is to have an iteration short enough to keep the team focused but long enough to deliver a meaningful increment of work.

## Sprint Reviews

In Scrum, each sprint is required to deliver a potentially shippable product increment. This means that at the end of each sprint, the team has produced a coded, tested and usable piece of software.

So at the end of each sprint, a sprint review meeting is held. During this meeting, the Scrum team shows what they accomplished during the sprint. Typically this takes the form of a demo of the new features.
https://www.mountaingoatsoftware.com/agile/scrum/sprint-review-meeting

## Sprint Retrospectives

No matter how good a development team is, there is always opportunity to improve. Although a good development team will be constantly looking for improvement opportunities, the team should set aside a brief, dedicated period at the end of each sprint to deliberately reflect on how they are doing and to find ways to improve. This occurs during the sprint retrospective.

The sprint retrospective is usually the last thing done in a sprint. Many teams will do it immediately after the sprint review. Occasionally a hot topic will arise or a team conflict will escalate. The retrospective gives developers the opportunity to bring up issues in a constructive way. 
https://www.mountaingoatsoftware.com/agile/scrum/sprint-retrospective

## DRY (Don't Repeat Yourself)

When you find that you are frequenlty copying and pasting the same code throughout an application it is usually a good indication that refactoring needs to be done that centralizes the functionality you are repeating in your code. A simple example would be a group of related methods you are calling, maybe it is crucial you call them in a particular order. This is an example of code needing a refactor. 

## KISS (Keep It Simple Stupid)

The KISS principle states that most systems work best if they are kept simple rather than made complicated; therefore simplicity should be a key goal in design and unnecessary complexity should be avoided. Write code that is simple as it can be to meet the requirements. Simple, elegant code is easier to maintain and easier for other developers to modify if needed.

## YAGNI (You Arent Gonna Need It)

The idea of not implementing a feature until it is truly needed. When prematurely implementing solutions wrong assumptions will be made. Wait until the feature or code change is truly a required. http://www.c2.com/cgi/wiki?YouArentGonnaNeedIt

## Definition of Done

A shared understanding of expectations that software must live up to in order to be releasable into production. Managed by the Development Team. It is difficult to have a definition of done when acceptance criteria are not clear. It is the task of the development team to clarify the definiton of done, without this the team is uncertain what to test and it is easy for new requirements to get added a feature. There will be misunderstandings if the team is not sure what requirement must be met. 

## Scope Creep

Refers to uncontrolled changes or continuous growth in a project’s scope. This can occur when the scope of a project is not properly defined, documented, or controlled. It is generally considered harmful. https://en.wikipedia.org/wiki/Scope_creep

## Pair Programming

Pair programming is an agile software development technique in which two programmers work together at one workstation. One, the driver, writes code while the other, the observer, reviews each line of code as it is typed in. The two programmers switch roles frequently.

While reviewing, the observer also considers the "strategic" direction of the work, coming up with ideas for improvements and likely future problems to address. This frees the driver to focus all of his or her attention on the "tactical" aspects of completing the current task, using the observer as a safety net and guide. https://en.wikipedia.org/wiki/Pair_programming

There are severl practical benefits to pair programming
1. Both developers become familiar with the code
2. Pair programming makes code reviews easier because the code has already been studied by two developers.
2. Less bugs are created using pair programming.

## Mob Programming

When all or several members of a development team work on the code  at the same time, in the same space, and at the same computer.
https://leanpub.com/mobprogramming

## Spike

A task aimed at answering a question or gathering information, rather than at producing shippable product. Sometimes a user story is generated that cannot be well estimated until the development team does some actual work to resolve a technical question or a design problem. The solution is to create a “spike,” which is some work whose purpose is to provide the answer or solution. http://agiledictionary.com/209/spike/

## MVC Pattern

A common design pattern found in many modern programming languages. MVC Pattern stands for Model-View-Controller Pattern. This pattern is used to separate an application's concerns. https://msdn.microsoft.com/en-us/library/dd381412(v=vs.108).aspx

## ORM (Object Relational Mapper)

An object relational mapper returns the data in database tables as objects that can be queried, created, updated and deleted. Typically the orm uses sql to execute sql against a database. https://en.wikipedia.org/wiki/Object-relational_mapping

## Refactor

The act of purposely cleaning up and refining existing code. 

## Code Smell

Refers to any symptom in the source code of a program that possibly indicates a deeper problem. The team must decide whether to ignore the issue or refactor the code. 

## Spaghetti Code

Spaghetti code is a derogatory term for computer programming that is unnecessarily convoluted, and particularly programming code that uses frequent branching from one section of code to another. Spaghetti code sometimes exists as the result of older code being modified a number of times over the years. The presence of spaghetti code is a sign the development has not taken care of technical debt by refactoring the code. 

## Technical Debt

Those activities that a team or team members chooses not to do now and will impede future development if left undone  It is called debt because the debt will eventually slow the team down. Eventually the technical debt needs to be addressed. As more time passes and new code integrates with the quick fixes, it will become more difficult and refactor the technical debt from the code. 







 
 









 
 


