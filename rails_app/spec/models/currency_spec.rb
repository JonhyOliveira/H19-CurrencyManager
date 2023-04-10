# frozen_string_literal: true

require "rails_helper"

RSpec.describe Currency, type: :model do
  it "is valid with acceptable parameters" do
    currency = Currency.new

    currency.code = Faker::Finance.ticker
    currency.symbol = "%"
    currency.name = Faker::Coin.name
    currency.name_plural = currency.name
    currency.latest_exchange_rate = 0.1
    currency.decimal_digits = 4

    expect { currency.save }.to change(Currency, :count)
  end

  context "is not valid" do
    # TODO need to do more extensive tests here
    it "with invalid symbol" do
      currency = Currency.new

      currency.code = nil
      currency.latest_exchange_rate = 1

      expect(currency).to_not be_valid

      currency.symbol = ""
      expect(currency).to_not be_valid
    end

    it "with invalid exchange rate" do
      currency = Currency.new

      currency.symbol = Faker::Finance.ticker
      currency.latest_exchange_rate = nil

      expect(currency).to_not be_valid

      currency.latest_exchange_rate = 0

      expect(currency).to_not be_valid
    end
  end
end
