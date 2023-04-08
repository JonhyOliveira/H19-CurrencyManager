require 'rails_helper'

RSpec.describe CurrencyFollowing, type: :model do

  before do 
    User.create email: "test@test", password: "test1234"
    Currency.create code: "XX", symbol: "€", name: "xixi", name_plural: "xixis"
  end

  it "is valid with correct parameters" do
    following = CurrencyFollowing.new

    following.follower = User.first
    following.followed_currency = Currency.first

    expect { following.save }.to change(CurrencyFollowing, :count), change { u.currency_followings.count }

  end

  context "is not valid with" do
    it "with nil parameters" do
      following = CurrencyFollowing.new

      following.follower_email = nil
      following.followed_currency_code = nil

      expect(following).to_not be_valid
    end

    it "with non existant email" do
      following = CurrencyFollowing.new
      Currency.create 

      following.follower_email = "invalid@local"
      following.followed_currency = Currency.first
      
      expect(following).to_not be_valid
    end

    it "with non existant currency code" do
      following = CurrencyFollowing.new

      following.follower_email = User.first
      following.followed_currency_code = "ZZZ"
      
      expect(following).to_not be_valid
    end
  end
end
