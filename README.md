# Currency Manager

This is an app in which a user can authenticate, follow and unfollow currencies. Additionally, the user can check the most recent exchange rates for the followed currencies.

## Deployment

The deployment was done via docker containers. With the architecture described in the `docker-compose.yml` file.

<u>These are the currently implemented features:</u>

* Authentication (using [*devise*](https://github.com/heartcombo/devise))
* Currencies Exchange Rate:
    * Listed
    * Updated on a configurable period (uses [*whenever*](https://github.com/javan/whenever) to easily configure the crontab)

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
