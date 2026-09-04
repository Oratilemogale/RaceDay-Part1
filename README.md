# RaceDay

RaceDay is a role-based race-event management system. The system helps organisers set up running events, create race categories, view entries and capture results. Participants can find events, enter a category, record a payment and view results.

This is the planning work for Part 1. The design is deliberately simple enough to be implemented in Part 2, while still covering the full RaceDay workflow.
## System objectives

The main objective of RaceDay is to provide a simple system for managing race events from creation through to results. The system is designed to reduce manual administration by keeping participant enrolments, payments and race results connected to the correct event and category.

## System scope

For Part 1, the system scope focuses on the planning and design of the core race-event workflow. This includes user roles, event and category management, participant enrolments, payment records and race results.

The project does not include the completed application interface or full backend implementation yet. These parts are intended for Part 2, using the planning documents created in this stage.

The planning also focuses on role-based access so that organisers can manage their own events while participants can manage their own profiles and enrolments.
## System roles

- **Organiser:** creates and manages only their own events and categories, views enrolments for those events, and records or corrects results.
- **Participant:** registers an account, updates their profile, enters available categories, records payment, cancels their own eligible enrolment, and views public results.

## Key system features

- **Event management:** organisers can create and manage race events and their categories.
- **Participant enrolment:** participants can select an available race category and create an enrolment.
- **Payment recording:** payment information is linked to the participant's enrolment.
- **Results management:** organisers can capture race results and participants can view public results.
- **Role-based access:** actions are restricted according to whether the user is an organiser or participant.

## Planning artefacts

- `docs/RaceDay_ERD.png` — ERD with six entities, their attributes, keys and relationship cardinalities.
- `docs/RaceDay_Endpoint_Plan.md` — planned REST API routes, roles, request bodies and responses.
- `docs/RaceDay_Database.sql` — SQL Server schema, constraints and realistic seed data.

The ERD and SQL match exactly: `Users`, `Events`, `Categories`, `Enrolments`, `Results` and `Payments`. The many-to-many relationship between participants and race categories is resolved by `Enrolments`.

## CI/CD

The GitHub Actions workflow at `.github/workflows/docs-validation.yml` checks that the three required planning files exist and that the core SQL tables are present on every push and pull request.

## Before submitting

1. Create a GitHub repository and upload this project.
2. Make meaningful commits as you work. The brief requires at least 20; do not create empty commits just to reach the number.
3. Open the **Actions** tab after pushing and wait for **Validate planning documents** to show a green tick. Take a screenshot and add it below.
4. Run `docs/RaceDay_Database.sql` in SSMS on a clean SQL Server instance. Show the successful run in your video.
5. Record an unlisted YouTube walkthrough. Explain the ERD choices, endpoint plan, roles, and the SQL script, then paste its link below.
6. Submit the GitHub repository link on ARC.

## Required evidence

- **Successful CI/CD build screenshot:** add your own screenshot here after the GitHub Action runs successfully.
- **Unlisted YouTube walkthrough:** paste your own video link here after recording it.
