# Currency Manager

This is an app in which a user can authenticate, follow and unfollow currencies. Additionally, the user can check the most recent exchange rates for the followed currencies.

## Deployment

The deployment was done via docker containers. With the architecture described in the `docker-compose.yml` file.

## Setup

1. Build and Deploy the services using `docker-compose` (first `build` and then `up`);
2. Get a shell inside the rails app container and run `bin/setup`;
3. Follow the instructions given by the previous command to finish setting up the environment;
4. (OPTIONAL) Run the `UpdateCurrenciesJob` job to seed the database with current data.

## Features

* 🔑 Authentication (using [*devise*](https://github.com/heartcombo/devise)).
* 🤑 Currencies, accompanied with exchange rate, updated using cron jobs (uses [*whenever*](https://github.com/javan/whenever) to easily configure the crontab).
* 👁️ Following currencies (there is support for the CurrencyFollower association but this is not yet implemented in the frontend).
* ⭐️ Favorite currency: users can set a favorite currency, based on which other currencies exchange rate will be shown.

## Testing

Testing is done using [`rspec`](https://github.com/rspec/rspec-rails).
