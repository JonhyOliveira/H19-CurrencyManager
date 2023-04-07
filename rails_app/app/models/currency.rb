# frozen_string_literal: true

class Currency < ApplicationRecord
  validates :symbol, presence: true, length: { minimum: 1 }
  validates :latest_exchange_rate, presence: true, numericality: { greater_than: 0 }

  def symbol=(val)
    self[:symbol] = val

    self[:symbol] = self[:symbol].upcase if self[:symbol].respond_to? :upcase!
  end
end
