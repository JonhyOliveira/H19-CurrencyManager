# Currency Manager

This is an app in which a user can authenticate, follow and unfollow currencies. Additionally, the user can check the most recent exchange rates for the followed currencies.

## Deployment

The deployment was done via docker containers. With the architecture described in the `docker-compose.yml` file.

## Features

* 🧑‍💻 Authentication (using [*devise*](https://github.com/heartcombo/devise))
* 🤑 Currencies, accompanied with exchange rate, updated using cron jobs (uses [*whenever*](https://github.com/javan/whenever) to easily configure the crontab)
* **PARCIAL FEAT** - 👁️ Following currencies (there is support for the CurrencyFollower association but this is not yet implemented in the frontend)

### TODO add here

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
