# Athlete Training App

A simple Rails app for managing athlete profiles, recording training sessions, and viewing basic performance stats. Includes a modern UI with **light/dark mode** and sport-based icons.

## Features

- **Accounts**: sign up, sign in, and sign out (passwords stored with `bcrypt`)
- **Authorization**: each signed-in user only sees their own athletes and training sessions
- **Athletes CRUD**: create, view, edit, and delete athlete profiles
- **Training sessions**: add sessions per athlete
- **Stats page**: shows total distance and average speed (based on recorded sessions)
- **Sport icon**: displays an icon next to an athlete name based on `sport_definition`
- **Theme toggle**: light/dark switch persisted in the browser (`localStorage`)

## Tech Stack

- **Ruby on Rails**: `~> 8.0.2` (see `Gemfile`)
- **Database**: SQLite (`sqlite3`)
- **Assets**: Propshaft + app CSS (`app/assets/stylesheets/application.css`)
- **Hotwire**: Turbo + Stimulus (installed via default Rails stack)

## Getting Started

### Prerequisites

- Ruby (compatible with Rails 8)
- Bundler
- SQLite installed

### Setup

From the project directory:

```bash
bundle install
bin/rails db:migrate
bin/rails server
```

Then open the app at `http://localhost:3000`.

## How to Use

### Account workflow

- Visit `/` (you will be redirected to sign in if you are not authenticated)
- Create an account at `/users/new`, or sign in at `/session/new`
- Sign out from the header button

### Athlete workflow

- Go to the Athletes list: `/athletes`
- Click **New athlete** to create a profile
- On an athlete profile page you can:
  - **View stats**
  - **Add training session**

### Training sessions

Training sessions are created under an athlete:

- `GET /athletes/:athlete_id/training_sessions/new`
- `POST /athletes/:athlete_id/training_sessions`

### Stats page

Each athlete has a stats page:

- `GET /athletes/:id/stats`

Calculated values:

- **Total distance**: sum of `training_sessions.total_distance`
- **Average speed**: average of `training_sessions.average_speed`

## Routes (high level)

Defined in `config/routes.rb`:

- `resource :session` (sign in/out)
- `resources :users, only: [:new, :create]` (sign up)
- `resources :athletes`
- `GET /athletes/:id/stats` (member route)
- `resources :training_sessions, only: [:new, :create]` nested under athletes
- Root: `home#show` (redirects to `/athletes` when signed in, otherwise `/session/new`)

## Data Model

### User

Has many athletes.

Key fields (see `db/schema.rb`):

- `email` (string, unique)
- `password_digest` (string)

### Athlete

Belongs to a user.

Has many training sessions.

Key fields (see `db/schema.rb`):

- `profile` (string)
- `name` (string)
- `age` (integer)
- `sport_definition` (string)
- `email` (string)
- `user_id` (foreign key)

### TrainingSession

Belongs to an athlete.

Key fields (see `db/schema.rb`):

- `date` (date)
- `start_time` (datetime)
- `finish_time` (datetime)
- `average_speed` (integer)
- `total_distance` (float)
- `athlete_id` (foreign key)

## UI / Theming

- The theme is controlled via `data-theme` on the `<html>` element (`light` or `dark`).
- The toggle switch lives in `app/views/layouts/application.html.erb`.
- Styles are in `app/assets/stylesheets/application.css`.

## Testing

This project uses the default Rails test framework.

```bash
bin/rails test
```

## Troubleshooting

- **Schema vs form fields**: ensure form fields match `db/schema.rb` (e.g. `average_speed` and `total_distance`).
- **CSS not updating**: hard refresh the browser, or restart the server if assets are cached.

