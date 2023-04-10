# frozen_string_literal: true
class ChangeCurrencyPkColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :currencies, :symbol, :code
  end
end
