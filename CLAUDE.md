# Police Board

A Rails web application for archiving and managing serious allegations of misconduct against the Chicago Police Department and its employees, as handled by the Chicago Police Board.

## Tech Stack

- **Backend:** Ruby 3.0 / Rails 6.1
- **Database:** PostgreSQL 11+
- **Frontend:** Webpacker 5.4, jQuery 3.6, DataTables, CoffeeScript
- **File Storage:** CarrierWave with AWS S3
- **Deployment:** AWS Elastic Beanstalk, RDS, CodePipeline
- **Server:** Puma

## Project Structure

```
app/
├── controllers/          # Rails controllers
│   └── extranet/         # Admin namespace controllers
├── models/               # ActiveRecord models
├── views/                # ERB templates
│   └── extranet/         # Admin interface views
├── javascript/packs/     # Webpacker entry points
├── assets/stylesheets/   # SCSS stylesheets
└── uploaders/            # CarrierWave file uploaders

config/
├── routes.rb             # URL routing
├── database.yml          # Database config
└── webpack/              # Webpack environment configs

db/
├── migrate/              # Database migrations
└── schema.rb             # Current schema
```

## Key Models

- `Case` - Police board cases (belongs to Defendant, has many BoardMemberVotes)
- `Defendant` - Police officers accused
- `BoardMember` - Board voting members with terms
- `Rule` - Charges/rules violated
- `Vote` - Voting options (Agree, Dissent, Abstain)
- `Outcome` - Case recommendations/decisions
- `User` - Admin users (Devise authentication)

## Routes

**Public:**
- `/` - Welcome page
- `/cases` - Case search and listing
- `/cases/:id` - Case details
- `/board` - Board members
- `/rules` - Rules/charges
- `/analytics` - Analytics dashboard

**Admin (Extranet):**
- `/extranet/cases` - Manage cases
- `/extranet/board_members` - Manage board members
- `/extranet/rules` - Manage rules
- `/extranet/superintendents` - Manage superintendents

## Development Commands

```bash
# Setup
bundle install
yarn install
rake db:create db:migrate db:seed

# Run server
rails server
# or
foreman start

# Compile assets
bundle exec rake webpacker:compile

# Import data from Excel
rake import:all
```

## Environment Variables

Local development uses `.env` file:
- `RACK_ENV`
- `PORT`
- `DATABASE_USERNAME`
- `DATABASE_PASSWORD`

Production uses AWS RDS variables:
- `RDS_DB_NAME`, `RDS_USERNAME`, `RDS_PASSWORD`, `RDS_HOSTNAME`, `RDS_PORT`

## Database

- Use `rails db:migrate` for schema changes
- Migrations in `db/migrate/`
- Seed data creates test user: `test@test.com` / `password`

## File Uploads

- CarrierWave handles uploads
- Development: local storage
- Production: AWS S3
- Uploaders in `app/uploaders/`

## Deployment

```bash
./build.sh  # Creates deploy/policeboard.zip for Elastic Beanstalk
```

## Key Dependencies

- `devise` - Authentication
- `simple_form` - Form builder
- `carrierwave` + `fog-aws` - File uploads with S3
- `will_paginate` - Pagination
- `roo` - Excel file import
- `tinymce-rails` - Rich text editor
- `twitter` - Twitter API integration

## Code Conventions

- Admin functionality lives in `extranet/` namespace
- Stylesheets use SCSS in `app/assets/stylesheets/`
- JavaScript entry points in `app/javascript/packs/`
- Use Webpacker for JavaScript bundling (not Sprockets)
