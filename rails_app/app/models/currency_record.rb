class CurrencyRecord < ApplicationRecord
    
    # same requirements as Currency
    validates :code, presence: true, uniqueness: { scope: :record_date }
    validates :record_date, presence: true
    validates :latest_exchange_rate, allow_nil: true, numericality: { greater_than: 0 }

    belongs_to :currency, foreign_key: :code

end
