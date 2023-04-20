class FixRelations < ActiveRecord::Migration[7.0]
  def change

    remove_column :currency_records, :code
    remove_column :users, :favorite_currency_code

    add_column :users, :favorite_currency_id, :bigint
    add_foreign_key :users, :currencies, column: :favorite_currency_id

  end
end
