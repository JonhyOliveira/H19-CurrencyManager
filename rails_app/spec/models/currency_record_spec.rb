# frozen_string_literal: true

require "rails_helper"

RSpec.describe CurrencyRecord, type: :model do
  it "is valid with acceptable parameters" do
    curr = Currency.create! code: Faker::Finance.ticker, symbol: "%", name: Faker::Coin.name,
      name_plural: Faker::Coin.name, latest_exchange_rate: 0.1, decimal_digits: 4

    currency_record = CurrencyRecord.new

    currency_record.currency_id = curr.id
    currency_record.latest_exchange_rate = 0.1
    currency_record.record_date = DateTime.now

    expect { currency_record.save }.to change(CurrencyRecord, :count)
  end

  context "is not valid" do
    # TODO need to do more extensive tests here
    it "with non-existant currency's code" do
      curr = Currency.create! code: Faker::Finance.ticker, symbol: "%", name: Faker::Coin.name,
        name_plural: Faker::Coin.name, latest_exchange_rate: 0.1, decimal_digits: 4

      currency_record = CurrencyRecord.new

      currency_record.currency_id = -1
      currency_record.latest_exchange_rate = 0.1
      currency_record.record_date = DateTime.now

      expect(currency_record).to_not be_valid

      currency_record.currency_id = curr.id

      expect(currency_record).to be_valid
    end

    it "with invalid exchange rate" do
      curr = Currency.create! code: Faker::Finance.ticker, symbol: "%", name: Faker::Coin.name,
        name_plural: Faker::Coin.name, latest_exchange_rate: 0.1, decimal_digits: 4

      currency_record = CurrencyRecord.new

      currency_record.currency_id = curr.id
      currency_record.record_date = DateTime.now
      currency_record.latest_exchange_rate = 0

      expect(currency_record).to_not be_valid

      currency_record.latest_exchange_rate = 0.1

      expect(currency_record).to be_valid
    end
  end
end
