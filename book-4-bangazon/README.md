# Book 4 - Bangazon Professional Preparation

This book introduces you to integration testing, and  Django templates. You will be writing raw SQL in some of your Django views instead of the ORM to produce reports for business analysts.

## 🍎 Required Core Chapters

| # | 🕹 🎲 <br/> Level Up <br/><sub>(_Guided Tour_)</sub> |
|--|--|
| 1 | [SQL Interlude: Chinook](./chapters/CHINOOK.md) <br/> <sub style="font-size:0.85rem;">#sql</sub> |
| 2 | [API Integration Testing](./chapters/TESTING.md) <br/> <sub style="font-size:0.85rem;">#testing</sub> |
| 3 | [Server Side Rendering (SSR)](./chapters/DJANGO_TEMPLATES.md) <br/> <sub style="font-size:0.85rem;">#sql #templates</sub> |
| 4 | [SSR Events by Gamer Report](./chapters/LU_EVENTS_BY_GAMER.md) <br/> <sub style="font-size:0.85rem;">#sql #templates</sub> |
| | [Job Preparation: Bangazon API](./chapters/BANG_SETUP.md) |

## 🧭 Explorer Chapters

Explorer chapters are optional, and give you the opportunity to expand on the Core chapters and the concepts in the book without any guidance or boilerplate code.

| # | Level Up | ⛅️ Deployment |
|--|--|--|
| 1 | [SQL: Database Views](./chapters/DB_VIEWS.md) <br/> <sub style="font-size:0.85rem;">#sql #views</sub> |[Digital Ocean Deploy Walkthrough](./chapters/DEPLOY_DJANGO_01.md) |
| 2 | [Django Permissions](./chapters/DJANGO_PERMISSIONS.md) | [Heroku Walkthrough](./chapters/HEROKU_DEPLOYMENT.md) |
| 3 | [Enforcing Permissions](./chapters/DJANGO_ENFORCING_PERMISSIONS.md) | [Swagger Interface](./chapters/SWAGGER.md) |
| 4 |  | [Automating Deployment with Github Actions](./chapters/GITHUB_ACTIONS.md) |

## 🏕 Pioneer Chapters

Pioneer chapters are optional and let you develop Deep Learning on the concepts you've learned so far in the course.

These Pioneer chapters are to help you deepen your algorithmic thinking skills.

> Each challenge includes test code so you can check your work. To run the tests:
>    1. Install pytest `pip3 install -U pytest`
>    2. `cd` into the folder with the test and run `pytest <file-name>.py` to see the test results

| Fundamentals | Intermediate | Advanced |
|--|--|--|
[Even or Odd](./whiteboarding/problems/even_or_odd.md)  | [Sum of Multiples](./whiteboarding/problems/add_multiples_of_3_5.md) | [Snail Pattern](./whiteboarding/problems/snail_pattern.md)
[Highest and Lowest](./whiteboarding/problems/highest_and_lowest.md) | [Palindrome](./whiteboarding/problems/palindrome.md)
[Map Over Lists](./whiteboarding/problems/map_over_list.md) | [RGB Color to Hex Color Code](./whiteboarding/problems/rgb_to_hex.md)

## 🚀 Into the Beyond

FAQ for capstone projects

| Question | Where to look |
|---|---|
| What are the requirements for my proposal? | It's on the [Learning Platform](https://learning.nss.team/) |
| What should my proposal include? | Read the [Capstone Proposal Guidelines](./chapters/CAPSTONE_EXAMPLE.md) document to get started. |
| How should I build my user stories? | Refer to [Rare Tickets](https://github.com/nss-group-projects/rare-client/issues) |
| How should I set up my project and directories? | The LevelUp chapters show you exactly how to do it. |
| How should I build my project README | It's on the [Learning Platform](https://learning.nss.team/) |
| How do I know who the authenticated user is? | Honey Rae project chapter 11 has a code block that shows you. |
| How often should I push to Github? | <ul><li>Each time you get something working</li><li>Each time you complete the code on a feature branch</li><li>If you feel anxious that it's been a while since your last push</li></ul>  |
| Can I work on my `main` branch since it's my capstone? | No. Never. We'll find you. **Always** work on a feature branch. |
| Should my ERD table names be plural? | No, stick with singular to conform with Django class naming rules. |


If you want more practice with whiteboarding visit these two platforms:

| Platform| URL|
|---|---|
| Codewars | https://www.codewars.com/ |
| HackerRank  | https://www.hackerrank.com/ |

