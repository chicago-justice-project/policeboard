# Police Board

A responsive web app for the archive of the most serious allegations of misconduct brought against the Chicago Police Department and its employees as handled by the Chicago Police Board.

## To run locally

Dependencies
* Ruby 2.2.0
* Bundler
* Rails 4
* PostgreSQL
* Foreman (install with `gem install foreman`)

### Clone the repo
From wherever you'd like the policeboard folder to be created, run:
`git clone https://github.com/ChicagoJusticeProject/policeboard.git`

### Config
Create a file named .env in the root, with the contents below.
```
RACK_ENV=development
PORT=3000
```

### Run
For the first time, make sure Postgres is running, then execute:
```
bundle install
rake db:create db:migrate
foreman start
```
For subsequent times, still with Postgres running first, just run `foreman start`. Occassionally you may need to preface that with:
`bundle install` if new gems (modules/plugins) are used in the app, or
`rake db:migrate db:import` if the database schema or raw input data have changed.

## Deployment

The app runs on AWS Elastic Beanstalk. Deployment docs coming soon.

