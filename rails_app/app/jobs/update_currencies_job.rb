# frozen_string_literal: true
class UpdateCurrenciesJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Currency.transaction do
      # update list of  currencies
      result = FreecurrencyApi.call endpoint: "currencies"

      unless result.failure?
        result.data.each_value do |currency_info|
          currency_info = currency_info.slice("name", "symbol", "code", "name_plural", "decimal_digits")

          curr = Currency.find_or_create_by code: currency_info["code"]
          curr.update currency_info
        end
      end

      # update exchange rates
      result = FreecurrencyApi.call endpoint: "latest"

      unless result.failure?
        result.data.each do |code, ex_rate|
          curr = Currency.find_by(code: code)
          unless curr.nil?
            curr.latest_exchange_rate = ex_rate
            curr.save
          end
        end
      end
    end
    # Currency.transaction do
    # 	response.body['data'].each { |symbol, rate|
    # 		currency = Currency.find_or_create_by symbol: symbol

    # 		unless currency.latest_exchange_rate == rate
    # 			currency.latest_exchange_rate = rate

    # 			currency.save
    # 		end
    # 	}
    # end
  end
end
