require 'rails_helper'

RSpec.describe Currency, type: :model do

	it "is valid with acceptable parameters" do
		currency = Currency.new

		currency.symbol = "X"
		currency.latest_exchange_rate = 0.1

		expect { currency.save }.to change(Currency, :count)

	end

	context "is not valid" do
		it "with invalid symbol" do
			currency = Currency.new

			currency.symbol = nil
			currency.latest_exchange_rate = 1

			expect(currency).to_not be_valid

			currency.symbol = ""
			expect(currency).to_not be_valid
		end

		it "with invalid exchange rate" do
			currency = Currency.new

			currency.symbol = "V"
			currency.latest_exchange_rate = nil

			expect(currency).to_not be_valid

			currency.latest_exchange_rate = 0

			expect(currency).to_not be_valid
		end
	end
end
