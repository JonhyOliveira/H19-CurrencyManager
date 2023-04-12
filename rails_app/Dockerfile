FROM ruby:3.0.6-bullseye

LABEL author="joao.oliveira@hole19golf.com"

# update the image and install necessary tools
RUN apt-get update
RUN apt-get install -y build-essential nodejs
# postgresql lib
RUN apt-get install -y libpq-dev

# admin utilities
RUN apt-get install -y nano

# package necessary for whenever
RUN apt-get install cron -y

# setup the workdir
RUN mkdir -p /rails_app
WORKDIR /rails_app

# install gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install --jobs 20 --retry 5

# install crontab with whenever gem
RUN mkdir ./config
COPY ./config/schedule.rb ./config/schedule.rb
RUN bundle exec whenever --update-crontab --set "environment=development"
RUN mkdir -p /var/log/cron

# copy the app
COPY . .

# serve the app
EXPOSE 3000
CMD [ "sh", "-c", "cron && bundle exec rails server -b 0.0.0.0"]