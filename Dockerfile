FROM ruby:1.9.3
RUN apt-get update && apt-get install imagemagick libmagickcore-dev \
libmagickwand-dev libmagick++-dev libxml2-dev libxslt-dev \
libpq-dev libssl-dev  -y
COPY Gemfile* ./
RUN bundler install

COPY . /code
WORKDIR /code
CMD ["bundle", "exec", "rails", "server"]
