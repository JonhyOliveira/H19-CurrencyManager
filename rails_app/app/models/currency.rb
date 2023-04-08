# frozen_string_literal: true

class Currency < ApplicationRecord
  validates :code, presence: true, length: { minimum: 1 }
  validates :latest_exchange_rate, allow_nil: true, numericality: { greater_than: 0 }
  validates :symbol, presence: true
  validates :name, presence: true
  validates :name_plural, presence: true

  def code=(val)
    self[:code] = val

    self[:code] = self[:code].upcase if self[:code].respond_to? :upcase!
  end
end
