class CreateCurrencyFollowing < ActiveRecord::Migration[7.0]
  def change
    create_table :currency_followings do |t|
      t.string :follower_email
      t.string :followed_currency_code

      t.foreign_key :users, column: :follower_email, primary_key: :email
      t.foreign_key :currencies, column: :followed_currency_code, primary_key: :code

      t.timestamps
    end
  end
end
