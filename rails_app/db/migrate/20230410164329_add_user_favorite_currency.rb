# frozen_string_literal: true

class AddUserFavoriteCurrency < ActiveRecord::Migration[7.0]
  def change

    change_table :users do |t|
      t.string :favorite_currency_code

      t.foreign_key :currencies, column: :favorite_currency_code, primary_key: :code
    end
  end
end
