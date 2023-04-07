FROM ruby:3.0.6-slim

LABEL author "joao.oliveira@hole19golf.com"

# update the image and install necessary tools
RUN apt-get update
RUN apt-get install -y build-essential nodejs
# postgresql lib
RUN apt-get install -y libpq-dev

# package necessary for whenever
RUN apt-get install cron -y

# setup the workdir
RUN mkdir -p /rails_app
WORKDIR /rails_app

# install gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install --jobs 20 --retry 5

# copy the app
COPY . .

# mounts whenever tasks and starts cron
RUN bundle exec whenever --update-crontab
RUN cron

# serve the app
EXPOSE 3000
CMD bundle exec rails server -b 0.0.0.0 