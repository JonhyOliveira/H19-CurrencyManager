# frozen_string_literal: true

# changes the currencies table to use a float exchange rate, instead of an integer
class ChangeCurrencyExRateIntToFloat < ActiveRecord::Migration[7.0]
  def change
    change_column(:currencies, :latest_exchange_rate, :float)
  end
end
