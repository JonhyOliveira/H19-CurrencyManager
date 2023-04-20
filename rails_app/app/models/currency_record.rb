# frozen_string_literal: true
class CurrencyRecord < ApplicationRecord

  # same requirements as Currency
  validates :currency_id, presence: true, uniqueness: { scope: :record_date }
  validates :record_date, presence: true
  validates :latest_exchange_rate, allow_nil: true, numericality: { greater_than: 0 }

  belongs_to :currency

end
