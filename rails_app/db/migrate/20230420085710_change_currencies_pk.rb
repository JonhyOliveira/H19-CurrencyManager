# frozen_string_literal: true
class ChangeCurrenciesPk < ActiveRecord::Migration[7.0]
  def change
    execute "ALTER TABLE currencies DROP CONSTRAINT currencies_pkey CASCADE;"

    add_column :currencies, :id, :primary_key
  end
end
