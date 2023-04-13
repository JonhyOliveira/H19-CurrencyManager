class CurrencyRecordsUniqueIndex < ActiveRecord::Migration[7.0]
  def change
    add_index :currency_records, [:code, :record_date], unique: true
  end
end
