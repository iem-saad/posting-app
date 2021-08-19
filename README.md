# posting-app 📱

# README 📖

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version 2.7.1, Rails version 6.0.4

* Database Used => Postgres

* Database initialization (enter database user and password in `config/database.yml`)

# Deployment instructions 🚀
  First of all clone the project and setup database.yml file. Make sure you have ruby & rails versions as described above.
  Then run the following command after opening cmd or ubuntu terminal in clonned directory.
  * `bundle install` to install all required gems.
  * `rake db:create` to create database, make sure your database user has rights to create database.
  * `rake db:migrate` to run all pending migrations & create db tables.
  * `rake db:seed` to create temporary data in application. 100 Users in our case, specified in `db/seeds.rb` folder.
