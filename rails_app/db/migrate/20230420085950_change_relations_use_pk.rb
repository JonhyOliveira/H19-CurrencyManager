# frozen_string_literal: true
class ChangeRelationsUsePk < ActiveRecord::Migration[7.0]
  def change
    change_table :currency_followings do |t|

      t.remove_index([:follower_email, :followed_currency_code])

      t.remove_foreign_key column: :follower_email if t.foreign_key_exists? column: :follower_email

      t.remove_foreign_key column: :followed_currency_code if t.foreign_key_exists? column: :followed_currency_code

      t.bigint :currency_id
      t.foreign_key :currencies

      t.bigint :user_id
      t.foreign_key :users

      t.index [:user_id, :currency_id], name: "unique_user+currency", unique: true
    end

    change_table :currency_records do |t|
      t.remove_index :code
      t.remove_index [:code, :record_date]

      t.remove_foreign_key column: :code if t.foreign_key_exists? column: :code

      t.bigint :currency_id
      t.foreign_key :currencies

      t.index :currency_id
      t.index [:currency_id, :record_date], name: "unique_currency+date", unique: true
    end
  end
end
