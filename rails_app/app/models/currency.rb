# frozen_string_literal: true

class Currency < ApplicationRecord

  validates :id, presence: true, length: { minimum: 1 }
  validates :latest_exchange_rate, allow_nil: true, numericality: { greater_than_or_equal: 0 }
  validates :symbol, presence: true
  validates :name, presence: true
  validates :name_plural, presence: true

  has_many :currency_followings, dependent: :destroy

  has_many :followers, class_name: "User", through: :currency_followings

  has_many :favorited_by, class_name: "User", foreign_key: :favorite_currency_id

  has_many :history, class_name: "CurrencyRecord"

  before_validation :capitalize_code

  def capitalize_code
    self.id = self.id.upcase if self.id.respond_to? :upcase!
  end

  def ex_rate_rounded
    self[:latest_exchange_rate].round(self[:decimal_digits])
  end

  def self.ransackable_associations(auth_object = nil)
    ["currency_followings", "favorited_by", "followers", "history"]
  end
end
