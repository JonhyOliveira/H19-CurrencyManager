require 'rails_helper'

RSpec.describe CurrencyFollowing, type: :model do
  before :each do
    CurrencyFollowing.destroy_all
    Rails.application.load_seed
  end

  it "is valid with correct parameters" do
    following = CurrencyFollowing.new

    following.follower = User.first
    following.followed_currency = Currency.first

    expect { following.save }.to change(CurrencyFollowing, :count)
      .and change { following.follower.currency_followings.count }.by(1)
                                                                  .and change {
                                                                         following.followed_currency.currency_followings.count
                                                                       }.by(1)
  end

  context "is not valid with" do
    it "nil parameters" do
      following = CurrencyFollowing.new

      following.follower = nil
      following.followed_currency = nil

      expect(following).to_not be_valid
    end

    it "non existant email" do
      following = CurrencyFollowing.new

      following.follower_email = "invalid@local"
      following.followed_currency = Currency.first

      expect(following).to_not be_valid
    end

    it "non existant currency code" do
      following = CurrencyFollowing.new

      following.follower = User.first
      following.followed_currency_code = "ZZZ"

      expect(following).to_not be_valid
    end

    it "already existing followings" do
      following = CurrencyFollowing.new

      following.follower = User.first
      following.followed_currency = Currency.first

      following.save

      copy = CurrencyFollowing.new

      copy.follower = following.follower
      copy.followed_currency = following.followed_currency

      expect(copy).to_not be_valid
    end
  end
end
