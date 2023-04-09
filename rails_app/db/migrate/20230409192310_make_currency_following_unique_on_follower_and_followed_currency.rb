class MakeCurrencyFollowingUniqueOnFollowerAndFollowedCurrency < ActiveRecord::Migration[7.0]
  def change

    change_table :currency_followings do |t|

      t.index [ :follower_email, :followed_currency_code ], unique: true, name: "unique_on_follower_+_followed_currency"

    end

  end
end
