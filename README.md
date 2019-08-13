# Police Board

A responsive web app for the archive of the most serious allegations of misconduct brought against the Chicago Police Department and its employees as handled by the Chicago Police Board.

## To run locally

Dependencies
* Ruby 2.2.9
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
rake db:seed
rake import:all
foreman start
```

For subsequent times, still with Postgres running first, just run `foreman start`. Occassionally you may need to preface that with:
`bundle install` if new gems (modules/plugins) are used in the app, or `rake db:migrate` if the database schema has changed, or `rake import:all` if raw input data has changed.

Note this data is obtained from excel spreadsheets included in the repo, and may vary from production. Also note that the "rake db:seed" command creates a test user that you can use to log into the administrative side of the application when you run it locally. The username is "test@test.com" and password is "password".

## Deployment

The app runs on AWS Elastic Beanstalk. The database lives on Amazon RDS. To deploy or make changes to the production environment, ask for an AWS login from a CJP administrator.

### Images

Some images are stored in AWS S3, while others are stored in the assets folder. The image uploading process for AWS is managed by [CarrierWave](https://rubydoc.info/gems/carrierwave/frames). For images handled by S3, if the image does not exist, expect to see a broken link as there is currently no fallback or placeholder.