# Nós.vc

Nós.vc is a crowdlearning plataform for inspiring encounters.


## Development environment

You'll need [RVM](https://rvm.io/) to isolate your development environment.

Make sure you install `Ruby 1.9.3` on your [RVM](https://rvm.io/).

Then just checkout the code, configure dependencies and run the tests:

1. Clone the repository:

 `git clone git://github.com/engageis/nos.vc.git`

2. Enter the repo directory and accept the [RVM](https://rvm.io/):

 `cd nos.vc`

 `yes` if solicited

3. Install [Bundler](http://gembundler.com/) into our [RVM](https://rvm.io/):

 `gem install bundler`

4. Install all dependencies from [Gemspec](http://docs.rubygems.org/read/chapter/20):

 `bundler install`

## Production environment

1. To deploy on heroku, you will need to install the "memcachier" addon:
  `heroku addons:add memcachier`

  Without this addon you may get the error "undefined method `split' for nil:NilClass", once the ENV["MEMCACHIER_SERVERS"] variable will be nil.

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

To [Catarse](http://github.com/catarse/catarse)'s code


# License

Copyright (c) 2012-2013 Engage and Nós.vc

Licensed under the MIT license (see MIT-LICENSE file)
