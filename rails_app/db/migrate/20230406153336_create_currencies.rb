# frozen_string_literal: true

# create the currencies table
class CreateCurrencies < ActiveRecord::Migration[7.0]
  def change
    create_table :currencies, id: false do |t|
      t.string :symbol, primary_key: true, null: false
      t.integer :latest_exchange_rate, null: false

      t.timestamps
    end
  end
end
