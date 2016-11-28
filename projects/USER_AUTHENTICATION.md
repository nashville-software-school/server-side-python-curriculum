# User Authentication

## Table of Contents

1. [Prerequisites](#prerequisites)
1. [What You Will Be Learning](#what-you-will-be-learning)
1. [Requirements](#requirements)
1. [Resources](#resources)

## Prerequisites

* Before starting this project, your team must have completed the [initial version of the site](./INITIAL_BANGAZON_SITE.md) project.
* You must use Visual Studio to build this project.
* [Authentication with Identity](https://docs.asp.net/en/latest/security/authentication/identity.html)

## What You Will Be Learning

### Local DB

Migrating from SQLite (if needed) to using SQL Server Local Db for storing data.

### Authentication

You will learn how to use the built-in authentication and authorization Identity package in .NET Core to create users and handle authenticating requests.

## Requirements

#### Enable Identity in the application.

1. Users should be able to register and login with an email address and password.
1. Instead of the active customer select element from the Initial Bangazon Site project:
  - When logged out, a register and login link should appear.
  - When logged in, "Hello [username]" and a logout link should appear.

#### Require registration or login when user wants to purchase a product.

1. Users should be informed they need to be logged in to complete the action if they:
  - Click the add to order button without being logged in.
  - Attempt to view the current order without being logged in.

## Resources
[Updated Twilio SMS](https://www.twilio.com/docs/libraries/csharp#installation-nextgen)
