# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_09_09_215445) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "currencies", id: :string, force: :cascade do |t|
    t.float "latest_exchange_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "symbol"
    t.string "name"
    t.string "name_plural"
    t.integer "decimal_digits"
    t.text "description"
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

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "favorite_currency_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "currency_followings", "currencies"
  add_foreign_key "currency_followings", "users"
  add_foreign_key "currency_records", "currencies"
  add_foreign_key "users", "currencies", column: "favorite_currency_id"
end
