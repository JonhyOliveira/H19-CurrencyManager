# frozen_string_literal: true

class Currency < ApplicationRecord
  validates :symbol, presence: true, length: { minimum: 1 }
  validates :latest_exchange_rate, presence: true, numericality: { greater_than: 0 }

  def symbol=(val)
    val = val.upcase if val.respond_to? :upcase

    self[:symbol] = val
  end
end
