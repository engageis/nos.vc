

# This is a fork of Nós.vc

Nós.vc is a crowdlearning plataform for inspiring encounters. We're using it to organize the courses on
Matehackers.

For the original project see <http://github.com/engageis/nos.vc>

## Development environment

~~You'll need [RVM](https://rvm.io/) to isolate your development environment.~~

~~Make sure you install `Ruby 1.9.3` on your [RVM](https://rvm.io/).~~

### Install rbenv and ruby 1.9.3

The project is now using [rbenv](https://github.com/sstephenson/rbenv). You can install ruby 1.9.3 with [rbenv install](https://github.com/sstephenson/rbenv#installing-ruby-versions).

1. Follow the instructions [here to install rbenv](https://github.com/sstephenson/rbenv#basic-github-checkout)

2. Make sure you have the packages `pkg-config build-essential libmagickcore-dev imagemagick libxml2-dev libxslt-dev libpq-dev libssl-dev libcurl4-openssl-dev` installed

3. Follow the instructions [here to install ruby-build](https://github.com/sstephenson/ruby-build#installing-as-an-rbenv-plugin-recommended) as an rbenv plugin.
4. Run `rbenv install 1.9.3-p194` the most up to date ruby version for this project is always in the file `.ruby-version`. 

### Checking out and running the code

Then just checkout the code, configure dependencies and run the tests:

1. Clone the repository:

 `git clone git://github.com/matehackers/nos.vc.git`

2. Enter the repo directory

3. Install [Bundler](http://gembundler.com/):

 `gem install bundler`

4. Refresh the rbenv ruby binaries

 `rbenv rehash`

5. Install all dependencies from [Gemspec](http://docs.rubygems.org/read/chapter/20):

 `bundle install`

6. Copy `config/database.sample.yml` to `config/database.yml` and create the `catarse_development` database 

7. Initialize the database

  `bundle exec rake db:create`
  
  `bundle exec rake db:migrate`

8. Run the server

  `bundle exec rails s`

### Production environment

To deploy on heroku, you will need to install the "memcachier" addon: `heroku addons:add memcachier`

Without this addon you may get the error "undefined method `split' for nil:NilClass", since the ENV["MEMCACHIER_SERVERS"] variable will be nil.

### Running tests

1. Go to app folder

	`cd nos.vc`

2. Prepare the database
	
	`bundle exec rake db:test:prepare`

3. Run the rspec

	`rspec spec/`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Thanks

To [Catarse](http://github.com/catarse/catarse)'s code. To the people at [Engage](http://engage.is/) and the original [Nós.vc](http://nos.vc/) code.

# License

Copyright (c) 2012-2013 Engage and Nós.vc

Licensed under the MIT license (see MIT-LICENSE file)
