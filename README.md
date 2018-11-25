Affordable Child Care Search Portal for Resource and Referral Networks
==================================================

What Is This?
--------------------------------------
This is a search portal for affordable child care resource and referral networks.

Where can I see it in action?
--------------------------------------
Here: http://childrenscouncil.org/childcaresearch/

Thank you!
--------------------------------------
Thank you for the generous support of San Francisco Human Services Agency (SF HSA) and the Office of Early Childhood Education (OECE). Thanks also to funders including S H Cowell Foundation.  This software was initially developed by Children's Council of San Francisco (http://childrenscouncil.org) and Exygy (http://exygy.com).

License
--------------------------------------
This affordable child care search portal for resource and referral networks is released under the MIT license:
www.opensource.org/licenses/MIT

Tech
--------------------------------------
This software is built in Ruby on Rails and Angular. It integrates well with other web tech. For example, it is currently embedded into a WordPress website and could easily be embedded into other platforms.

### Setup
- Install Ruby 2.5.0
- Install Node >=8.10.0
- Install Bundler: `gem install bundler`
- Install the pg gem: `gem install pg -v 0.21.0 -- --with-pg-config=[path to your pg_config]`
- Run `bundle install`
- Make a copy of `database.yml.sample`, save it in the same directory, and name it `database.yml`
- Run `rake db:create`
- Install the PostgreSQL citext extension in your local development and test databases. From your psql prompt, run:
  - `\c childrens_council_development`
  - `CREATE EXTENSION citext;`
  - `\c childrens_council_test`
  - `CREATE EXTENSION citext;`
- Run `rake db:migrate`
- Run `npm install`
- Run `./node_modules/.bin/bower install`
- Run `rails s` to start your server

Contributing, Questions, and Overview
--------------------------------------
We hope to have more info here soon about contributing to the project. In the meantime, please address any questions to hello@exygy.com and we'll send your email along to the right folks.
