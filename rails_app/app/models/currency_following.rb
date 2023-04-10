# frozen_string_literal: true
class CurrencyFollowing < ApplicationRecord
  validates :follower, presence: true
  validates :followed_currency, presence: true

  validates :follower,
            uniqueness: { scope: :followed_currency, message: "must be assigned to each currency at most once." }
  validates :followed_currency, uniqueness: { scope: :follower, message: "must be assigned to each user at most once." }

  belongs_to :follower, class_name: "User", primary_key: :email, foreign_key: :follower_email
  belongs_to :followed_currency, class_name: "Currency", primary_key: :code, foreign_key: :followed_currency_code
end
