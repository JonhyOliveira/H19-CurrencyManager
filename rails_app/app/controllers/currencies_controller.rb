# frozen_string_literal: true

#
# This class controls the /currencies endpoint
#
class CurrenciesController < ApplicationController
  # GET /currencies or /currencies.json
  def index
    @currencies = Currency.all
  end

  # GET /currencies/EUR or /currencies/EUR.json
  def show
    @currency = Currency.find(params[:id])
  end

  # PUT /currencies/EUR/follow
  def follow
    before_action :authenticate_user!

    user = current_user
    currency = Currency.find(params[:id])

    CurrencyFollowerManager.call user: user, currency: currency, follow: true
  end

  # PUT /currencies/EUR/unfollow
  def unfollow
    before_action :authenticate_user!

    user = current_user
    currency = Currency.find(params[:id])

    CurrencyFollowerManager.call user: user, currency: currency, follow: false
  end

end
