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

### Troubleshooting

If running the app using Ubuntu or Windows Subsystem for Linux (WSL), you may come across an error similar to this when trying to access the app on your browser:

>could not connect to server: No such file or directory Is the server running locally and accepting connections on Unix domain socket "/var/run/postgresql/.s.PGSQL.5432"?

To fix this, try adding `host: localhost` to the default settings section in the `database.yml` file.

## Deployment

The app runs on AWS Elastic Beanstalk. The database lives on Amazon RDS. 
To deploy or make changes to the production environment, ask for an AWS login from a CJP administrator.

To deploy, create a zip bundle by using the build.sh script in the root director.  This will create
a zip file in deploy/ called "policeboard.zip".  You can then upload this to Elastic Beanstalk.  

All builds should go to Staging first and be vetted there.  Once they are working correctly, they can then
be promoted to production from within Elastic Beanstalk.

### Images

Some images are stored in AWS S3, while others are stored in the assets folder. 
The image uploading process for AWS is managed by [CarrierWave](https://rubydoc.info/gems/carrierwave/frames). 
For images handled by S3, if the image does not exist, it will display a fallback image.

CarrierWave automatically intercepts any requests for an S3 sourced image to the /uploads path.  If S3 is configured
as it is in staging and production, the path will automatically be transposed to the S3 path.  S3 files should be
configured for public read access.

### Gitpod Instructions

The repo should now properly support the use of Gitpod.io.  To use gitpod, fork the CJP repo, and then follow the instructions
at the Gitpod.io site: https://www.gitpod.io/docs/getting-started/

Gitpod will spin up with a Postgres environment and should initialize the database for you.  The only step you'll need to take 
after launch is to run the "foreman start" command.  At that point, it should start the server.  You'll need to open the port in
Gitpod, but then you should be all set.  