# RaceDay Part 1 submission checklist

Use this checklist before submitting the repository link on ARC.

## Required files

- [x] `RaceDay_ERD.png` — includes six entities, attributes, primary keys, foreign keys and relationship cardinalities.
- [x] `RaceDay_Endpoint_Plan.md` — covers authentication, profiles, events, categories, enrolments and results.
- [x] `RaceDay_Database.sql` — creates the full SQL Server schema and inserts sample data.
- [x] `.github/workflows/docs-validation.yml` — checks the required planning files.
- [x] `README.md` — explains the system and both roles.

## Things you must do in your own GitHub/SSMS account

- [ ] Create or connect a GitHub repository.
- [ ] Make at least 20 meaningful commits while developing the project. Each commit should describe a real change, for example: `Add Users table`, `Add event seed data`, or `Document result endpoints`.
- [ ] Push the repository and confirm that the GitHub Action is green.
- [ ] Take a screenshot of the successful Action and insert it in the README.
- [ ] Run the SQL script in SSMS and check that all tables and seed records are created.
- [ ] Record an unlisted YouTube video: introduce RaceDay, explain both roles, walk through the ERD, discuss the endpoint plan, then run the script in SSMS.
- [ ] Paste the YouTube link into the README.
- [ ] Submit the GitHub repository URL on ARC.

## Suggested video structure

1. Introduce the RaceDay system and explain what an organiser and participant can do.
2. Show the ERD. Explain that `Enrolments` links participants to categories and handles the many-to-many relationship.
3. Show the endpoint plan. Explain that routes are protected according to role and ownership.
4. Open SSMS, run the SQL script, then show the six created tables and sample data.
5. Open GitHub Actions and show the green workflow run.
