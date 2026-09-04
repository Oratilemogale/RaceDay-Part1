# RaceDay API endpoint plan

Base URL: `/api`. Roles are `Organiser` and `Participant`. “Any” means an authenticated user. An organiser can manage only records belonging to their own events; a participant can manage only their own profile and enrolments.

| HTTP method | Route | Description | Role required | Request body | Expected response |
|---|---|---|---|---|---|
| POST | `/api/auth/register` | Registers an organiser or participant account. | None (public) | `{ fullName, email, password, role, phoneNumber }` | `201 Created` — user and JWT; `400` validation error; `409` email exists. |
| POST | `/api/auth/login` | Authenticates a user and issues a JWT. | None (public) | `{ email, password }` | `200 OK` — user and JWT; `401` invalid credentials. |
| GET | `/api/users/me` | Returns the signed-in user profile. | Any | None | `200 OK` — profile; `401` unauthenticated. |
| PUT | `/api/users/me` | Updates the signed-in user’s profile. | Any | `{ fullName, phoneNumber }` | `200 OK` — updated profile; `400` invalid data; `401` unauthenticated. |
| GET | `/api/events` | Lists published events; supports optional date/status filtering. | None (public) | None | `200 OK` — event collection. |
| GET | `/api/events/{eventId}` | Returns an event with its categories. | None (public) | None | `200 OK` — event; `404` event missing. |
| POST | `/api/events` | Creates an event owned by the current organiser. | Organiser | `{ name, description, eventDate, venue }` | `201 Created` — event; `400` invalid data; `403` wrong role. |
| PUT | `/api/events/{eventId}` | Updates an organiser-owned event. | Organiser (owner) | `{ name, description, eventDate, venue, status }` | `200 OK` — updated event; `403` not owner; `404` missing. |
| DELETE | `/api/events/{eventId}` | Cancels/removes an organiser-owned event with no active enrolments. | Organiser (owner) | None | `204 No Content`; `403` not owner; `404` missing; `409` active enrolments. |
| GET | `/api/events/mine` | Lists events created by the current organiser. | Organiser | None | `200 OK` — event collection; `403` wrong role. |
| GET | `/api/events/{eventId}/categories` | Lists categories for an event. | None (public) | None | `200 OK` — category collection; `404` event missing. |
| POST | `/api/events/{eventId}/categories` | Adds a category to an organiser-owned event. | Organiser (owner) | `{ name, distanceKm, entryFee, capacity }` | `201 Created` — category; `403` not owner; `404` event missing; `409` duplicate name. |
| PUT | `/api/categories/{categoryId}` | Updates a category for an organiser-owned event. | Organiser (owner) | `{ name, distanceKm, entryFee, capacity }` | `200 OK` — updated category; `403` not owner; `404` missing. |
| DELETE | `/api/categories/{categoryId}` | Removes an empty category from an organiser-owned event. | Organiser (owner) | None | `204 No Content`; `403` not owner; `404` missing; `409` enrolments exist. |
| POST | `/api/categories/{categoryId}/enrolments` | Enrols the current participant in a category. | Participant | `{ }` | `201 Created` — enrolment; `400` closed event; `403` wrong role; `404` missing; `409` duplicate/full category. |
| GET | `/api/enrolments/me` | Lists the current participant’s enrolments. | Participant | None | `200 OK` — enrolment collection; `403` wrong role. |
| GET | `/api/events/{eventId}/enrolments` | Lists enrolments for an organiser-owned event. | Organiser (owner) | None | `200 OK` — enrolment collection; `403` not owner; `404` missing. |
| DELETE | `/api/enrolments/{enrolmentId}` | Cancels the participant’s own enrolment before the event. | Participant (owner) | None | `204 No Content`; `403` not owner; `404` missing; `409` event already started. |
| POST | `/api/enrolments/{enrolmentId}/payment` | Records payment for the participant’s own enrolment. | Participant (owner) | `{ paymentReference }` | `201 Created` — payment; `403` not owner; `404` missing; `409` already paid/reference used. |
| GET | `/api/events/{eventId}/results` | Lists published results for an event. | None (public) | None | `200 OK` — ordered results; `404` event missing. |
| POST | `/api/enrolments/{enrolmentId}/result` | Records a result for an organiser-owned event enrolment. | Organiser (owner) | `{ finishTimeSeconds, position, resultStatus }` | `201 Created` — result; `400` invalid result; `403` not owner; `404` missing; `409` result/position exists. |
| PUT | `/api/results/{resultId}` | Corrects a result for an organiser-owned event. | Organiser (owner) | `{ finishTimeSeconds, position, resultStatus }` | `200 OK` — updated result; `403` not owner; `404` missing; `409` position exists. |
