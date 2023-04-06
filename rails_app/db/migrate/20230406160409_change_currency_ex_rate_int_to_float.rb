class ChangeCurrencyExRateIntToFloat < ActiveRecord::Migration[7.0]
  def change
    change_column(:currencies, :latest_exchange_rate, :float)
  end
end
