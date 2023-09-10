class BigBang < ActiveRecord::Migration[7.0]
  def change
    create_table :currencies, id: :string do |t|
      t.float "latest_exchange_rate"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "symbol"
      t.string "name"
      t.string "name_plural"
      t.integer "decimal_digits"
    end

    create_table "currency_followings", force: :cascade do |t|
      t.string "follower_email"
      t.string "followed_currency_code"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "currency_id"
      t.integer "user_id"
      t.index ["user_id", "currency_id"], name: "unique_user+currency", unique: true
    end

    create_table "currency_records", force: :cascade do |t|
      t.date "record_date", null: false
      t.float "latest_exchange_rate", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "currency_id"
      t.index ["currency_id", "record_date"], name: "unique_currency+date", unique: true
      t.index ["currency_id"], name: "index_currency_records_on_currency_id"
      t.index ["record_date"], name: "index_currency_records_on_record_date"
    end

    add_foreign_key "currency_followings", "currencies"
    add_foreign_key "currency_followings", "users"
    add_foreign_key "currency_records", "currencies"
    add_column :users, :favorite_currency_id, :string
    add_foreign_key "users", "currencies", column: "favorite_currency_id"
  end
end
