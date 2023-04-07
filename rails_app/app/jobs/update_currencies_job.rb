class UpdateCurrenciesJob < ApplicationJob
  $job_count = 0

  queue_as :default

  @@endpoint = Faraday.new "https://api.freecurrencyapi.com/v1/latest?apikey=#{Rails.application.credentials.free_currency[:API_key]}" do |f|
    f.response :json
    f.adapter :net_http
  end

  def initialize
    $job_count += 1
    super
  end

  def perform(*_args)
    response = @@endpoint.get

    Currency.transaction do
      response.body['data'].each { |symbol, rate|
        currency = Currency.find_or_create_by symbol: symbol

        unless currency.latest_exchange_rate == rate
          currency.latest_exchange_rate = rate

          currency.save
        end
      }
    end
  end
end
