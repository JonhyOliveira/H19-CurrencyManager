# frozen_string_literal: true
class CreateCurrencyRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :currency_records do |t|
      t.string :code, null: false
      t.date :record_date, null: false
      t.float :latest_exchange_rate, null: false

      t.index :record_date
      t.index :code

      t.timestamps
    end
  end
end
