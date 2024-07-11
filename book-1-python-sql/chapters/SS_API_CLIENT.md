# Revisiting React

Your skills and understand of React decay quickly now that you are learning Python and SQL. Therefore, it's time for each member of the team to build their own React client that works with the API that you just explored and augmented.

## User Stories

## View all assets

**Given** a person wants to use the Shipping Ships app

**When** the person visits http://localhost:3000

**Then** a list of all ships, all haulers, and all docks should be displayed, in that order, under an appropriate header element.

**And** there should be a navigation bar at the top of the screen with the following three links

1. Ships
2. Haulers
3. Docks

---

## View all ships

**Given** a person wants to manage ships

**When** the person visits http://localhost:3000/shippingships

**Then** a list of all ships should be displayed. Each list item should display the name of the ship, and the name of the hauler that is carrying it.

**And** a **Delete** button should be next to each one

---

## Delete a ship

**Given** a person wants to record that a ship has been lost at sea

**When** the person clicks the **Delete** button next to a ship on the ship list

**Then** the ship should be removed from the database and the UI should immediately re-render to ensure that it no longer appears

---

## View all haulers

**Given** a person wants to manage ships

**When** the person visits http://localhost:3000/haulingships

**Then** a list of all hauler names should be displayed

**And** an **Edit** button should be next to each one

---

## Edit a hauler

**Given** a person wants to change the name of a hauler

**When** the person clicks the **Edit** button for a hauler ship

**Then** a form should be rendered with two fields and an **Update** button

1. A text input element that is pre-filled with the hauler's current name
2. A select element that displays all of the docks, and the hauler's current dock assignment should be pre-chosen.

**And** when the **Update** button is clicked, the information for that hauler should be changed in the database, and the person should then be shown the list of haulers.

---

## View all docks

**Given** a person wants to see all docks

**When** the person visits http://localhost:3000/docks

**Then** a list of all docks should be rendered. Each item in the list should display the dock name and its tonnage capacity

**And** underneath each dock, as a bulleted list, all haulers currently assigned to that dock should be rendered.


