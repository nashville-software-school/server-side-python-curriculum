# Modern Bangazon API Client Application

## Authentication

You will learn how to use the built-in authentication and authorization modules in Django and DRF to create users and handle authenticating requests. You will learn how to use the Token Authentication system rather than the Session Authentication.

## Requirements

We need to build a mobile-response, single page application for use on mobile devices. This project will eventually be used as the prototype for an Ionic application. You are not responsible for that migration.

### Story

**As a** Bangazon customer

**In order** to sell, or buy, a product at any time

**I want** to be able to access the Bangazon site on my phone

### Scenarios

**Given** a customer wants to buy or sell a product

**When** the customer opens the Bangazon mobile app

**Then** the customer should be shown the last 20 products added to the platform

**And** have an affordance to perform a product search

**And** have an affordance to authenticate

---

**Given** a customer is viewing a product list

**When** the customer performs a gesture on a product link

**Then** the customer should be presented with the product details

**And** an affordance for adding the product to their shopping cart

---

**Given** a customer is on any view

**When** the customer performs a gesture on the affordance to authenticate

**Then** the customer should be presented with the log in view

---

**Given** a customer is authenticated

**When** the customer performs a gesture on the affordance to add a product to the shopping cart

**Then** the customer should see that the item was successfully added by an affordance in the navigation area which shows the number of items in their cart

---

**Given** a customer wants to view their shopping cart

**When** the customer performs a gesture on the cart affordance in the navigation area

**Then** the customer should be presented with a list of items in their cart

**And** the total price of the items in their cart

**And** an affordance to select a payment type

**And** an affordance to complete the order
