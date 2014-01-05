

# This is a fork of Nós.vc

Nós.vc is a crowdlearning plataform for inspiring encounters. We're using it to organize the courses on
Bunker360.

For the original project see <http://github.com/engageis/nos.vc>

## Development environment


~~You'll need [RVM](https://rvm.io/) to isolate your development environment.~~

~~Make sure you install `Ruby 1.9.3` on your [RVM](https://rvm.io/).~~

The project is now using [rbenv](https://github.com/sstephenson/rbenv). You can install ruby 1.9.3 with [rbenv install](https://github.com/sstephenson/rbenv#installing-ruby-versions).

Then just checkout the code, configure dependencies and run the tests:

1. Clone the repository:

 `git clone git://github.com/matehackers/nos.vc.git`

2. Enter the repo directory

3. Install [Bundler](http://gembundler.com/):

 `gem install bundler`

4. Install all dependencies from [Gemspec](http://docs.rubygems.org/read/chapter/20):

 `bundler install`

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
