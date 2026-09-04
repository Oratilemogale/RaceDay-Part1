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

## RaceDay workflow

The main workflow starts when an organiser creates an event and adds one or more race categories. Participants can then view available events, choose a category and create an enrolment.

After an enrolment is created, the related payment can be recorded. Once the race has taken place, the organiser can capture the participant's result. The participant can then view the result as part of the public race results.

## Planning artefacts

- `docs/RaceDay_ERD.png` — ERD with six entities, their attributes, keys and relationship cardinalities.
- `docs/RaceDay_Endpoint_Plan.md` — planned REST API routes, roles, request bodies and responses.
- `docs/RaceDay_Database.sql` — SQL Server schema, constraints and realistic seed data.

Each artefact supports a different part of the system design. The ERD provides the visual structure of the database, the endpoint plan describes how the application will communicate with the backend, and the SQL script provides the database implementation that can be tested in SQL Server.  

The ERD and SQL match exactly: `Users`, `Events`, `Categories`, `Enrolments`, `Results` and `Payments`. The many-to-many relationship between participants and race categories is resolved by `Enrolments`.

The relationships are designed to keep the data connected across the race process. An organiser can have multiple events, an event can contain multiple categories, and participants can enrol in categories through the Enrolments entity. Payments and results are associated with the relevant enrolment so that each participant's race information can be traced back to the correct event.

## Data integrity

The database design uses primary keys to uniquely identify records and foreign keys to maintain relationships between related entities. Required fields and constraints are used where appropriate to reduce incomplete or invalid records.

This approach helps ensure that enrolments, payments and results cannot become disconnected from the users, events and categories they belong to.

## Planning assumptions

The planning assumes that each participant has one user account and that organisers are responsible for managing the events assigned to them. A race category belongs to a specific event, while an enrolment connects a participant to the category they selected.

The payment and result records are linked to enrolments so that the system can keep the race information organised around each participant's entry.

## CI/CD

The GitHub Actions workflow at `.github/workflows/docs-validation.yml` checks that the three required planning files exist and that the core SQL tables are present on every push and pull request.

The validation workflow provides an early check that the main planning artefacts have not been accidentally removed or renamed. This gives the project a basic automated quality check before the repository is submitted.

## Technology notes

The database planning is based on SQL Server and the API is planned as a REST-style backend. The endpoint structure is intended to provide clear separation between user, event, category, enrolment, payment and result operations.

The planning documents are kept independent from the final application code so that they can be used as a reference during Part 2 implementation.

## Security considerations

Role-based access is an important part of the RaceDay design. Organiser actions should be limited to the events they are responsible for, while participants should only be able to manage their own profile and eligible enrolments.

The final application should also validate user input and protect operations that create or update race information. These considerations will be carried into the Part 2 implementation.

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
