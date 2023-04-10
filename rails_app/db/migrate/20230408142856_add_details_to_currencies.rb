# frozen_string_literal: true
class AddDetailsToCurrencies < ActiveRecord::Migration[7.0]
  def change
    change_column_null :currencies, :latest_exchange_rate, true
    change_table :currencies do |t|
      t.string :symbol
      t.string :name
      t.string :name_plural
      t.integer :decimal_digits
    end
  end
end
