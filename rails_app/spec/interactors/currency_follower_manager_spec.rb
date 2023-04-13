# frozen_string_literal: true
require "rails_helper"

RSpec.describe CurrencyFollowerManager, type: :interactor do

  before do
    Rails.application.load_seed
  end

  describe ".call" do
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

        it "beahaves like {follow: true}" do
          result = CurrencyFollowerManager.call parameters.call

          expect(result.success?).to be true

          result = CurrencyFollowerManager.call parameters.call.merge follow: true

          expect(result.failure?).to be true
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

        it "fails to create duplicates" do
          result = CurrencyFollowerManager.call parameters.call

          expect(result.success?).to be true

          5.times do
            expect((result = CurrencyFollowerManager.call parameters.call).failure?).to be true
          end
        end

        it "does not create duplicates" do
          expect { CurrencyFollowerManager.call parameters.call }.to change(CurrencyFollowing, :count)
          
          5.times do
            expect { CurrencyFollowerManager.call parameters.call }.to_not change(CurrencyFollowing, :count)
          end
        end

        # TODO test follow limit (waiting for Currency/User factories)
      end

      context "and {follow: false} context is provided" do
        parameters = Proc.new { { user: User.first, currency: Currency.first, follow: false } }

        context "with an existing following" do

          before :each do
            CurrencyFollowerManager.call parameters.call.merge follow: true
          end

          it "succeds" do
            result = CurrencyFollowerManager.call parameters.call

            expect(result.success?).to be true
          end

          it "removes an existing association" do
            expect { CurrencyFollowerManager.call parameters.call }.to change(CurrencyFollowing, :count)
          end

          it "fails when removing multiple" do
            expect { CurrencyFollowerManager.call parameters.call }.to change(CurrencyFollowing, :count)
            
            5.times do
              expect { CurrencyFollowerManager.call parameters.call }.to_not change(CurrencyFollowing, :count)
            end
          end
        end
      end
    end
  end
end
