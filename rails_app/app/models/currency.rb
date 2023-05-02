# frozen_string_literal: true

class Currency < ApplicationRecord

  validates :code, presence: true, allow_nil: false, length: { minimum: 1 }
  validates :latest_exchange_rate, allow_nil: true, numericality: { greater_than: 0 }
  validates :symbol, presence: true
  validates :name, presence: true
  validates :name_plural, presence: true

  has_many :currency_followings, dependent: :destroy

  has_many :followers, class_name: "User", through: :currency_followings

  has_many :favorited_by, class_name: "User", foreign_key: :favorite_currency_id

  has_many :history, class_name: "CurrencyRecord"

  def code=(val)
    self[:code] = val

    self[:code] = self[:code].upcase if self[:code].respond_to? :upcase!
  end

  def ex_rate_rounded
    self[:latest_exchange_rate].round(self[:decimal_digits])
  end
end
