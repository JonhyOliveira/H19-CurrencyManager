require 'rails_helper'

RSpec.describe CurrencyFollowerManager, type: :interactor do
  
  before :each do
    CurrencyFollowing.destroy_all
    Rails.application.load_seed
  end

  describe '.call' do
    describe "fails when provided with invalid context" do
      context "such as" do

        it "insufficent context" do
          expect(CurrencyFollowerManager.call.failure?).to be true
    
          expect(CurrencyFollowerManager.call(user: User.first).failure?).to be true
    
          expect(CurrencyFollowerManager.call(currency: Currency.first).failure?).to be true
        end

        it "invalid user" do
          expect(CurrencyFollowerManager.call(user: 3, currency: Currency.first).failure?).to be true
        end

        it "invalid currency" do
          expect(CurrencyFollowerManager.call(user: User.first, currency: 5).failure?).to be true
        end
      end
    end

    describe "when provided with valid user and currency context" do
      context "but no follow context is provided" do

        parameters = Proc.new { { user: User.first, currency: Currency.first } }
        
        it "succeds" do
          result = CurrencyFollowerManager.call parameters.call

          expect(result.success?).to be true
        end

        it "creates a new association" do
          expect { CurrencyFollowerManager.call parameters.call }.to change(CurrencyFollowing, :count)
        end
      end

      context "and {follow: true} context is provided" do

        parameters = Proc.new { { user: User.first, currency: Currency.first, follow: true } }

        it "succeds" do
          result = CurrencyFollowerManager.call parameters.call

          expect(result.success?).to be true
        end

        it "creates a new association" do
          expect { CurrencyFollowerManager.call parameters.call }.to change(CurrencyFollowing, :count)
        end
      end
    end
  end
end
