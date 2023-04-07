class Currency < ApplicationRecord
    validates :symbol, presence: true, length: { minimum: 1 }
    validates :latest_exchange_rate, presence: true, numericality: { greater_than: 0 }

    def symbol= val
        if val.respond_to? :upcase
            val = val.upcase
        end

        self[:symbol] = val
    end
end
