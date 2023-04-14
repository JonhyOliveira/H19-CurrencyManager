# frozen_string_literal: true
class CurrencyRecordsForeignKey < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :currency_records, :currencies, column: :code, primary_key: :code
  end
end
