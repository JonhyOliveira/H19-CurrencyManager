# Currency Manager

This is an app in which a user can authenticate, follow and unfollow currencies. Additionally, the user can check the most recent exchange rate for the followed currencies. Historical data is also available in the form of graphs.

See **[features](#features)** for more details.

## Deployment

The deployment was done via docker containers. With the architecture described in the `docker-compose.yml` file.

## Setup

1. Build and Deploy the services using `docker-compose` (first `build` and then `up`);
2. Get a shell inside the rails app container and run `bin/setup`;
3. Follow the instructions given by the previous command to finish setting up the environment;
4. Run `bin/post_setup` to populate the database with data from the external API (FreecurrencyAPI). Your other option is to wait for up to a week.

## Features

### 🔑 Authentication
Using [*devise*](https://github.com/heartcombo/devise)

![](/assets/auth.png)

---

### 🤑 Currencies
Accompanied with exchange rate, updated using cron jobs (uses [*whenever*](https://github.com/javan/whenever) to easily configure the crontab)

![](/assets/currencies.png)

---

### 👁️ Following currencies

![](/assets/follow.png)
![](/assets/follow2.png)

---

### ⭐️ Favorite currency 
Users can set a favorite currency, based on which other currencies' exchange rate will be shown

![](/assets/favorite.png)
![](/assets/favorite2.png)

---

### 🤩 Historical Data 
Loaded using the crontab, displayed by [*Chart.js*](https://www.chartjs.org/docs/4.2.1/)

![](/assets/graphs%F0%9F%A4%A9.png)

## Testing

You can test the project using [`rspec`](https://github.com/rspec/rspec-rails).