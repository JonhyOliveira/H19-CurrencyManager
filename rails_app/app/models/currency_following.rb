class CurrencyFollowing < ApplicationRecord
  validates :follower, presence: true
  validates :followed_currency, presence: true

  belongs_to :follower, class_name: "User", primary_key: :email, foreign_key: :follower_email
  belongs_to :followed_currency, class_name: "Currency", primary_key: :code, foreign_key: :followed_currency_code
end
