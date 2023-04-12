# frozen_string_literal: true

#
# This class controls the /currencies endpoint
#
class CurrenciesController < ApplicationController

  before_action :authenticate_user!, only: [ :follow, :unfollow, :followed ]

  # GET /currencies or /currencies.json
  def index
    if user_signed_in?
      redirect_to followed_currencies_path
    else
      redirect_to all_currencies_path
    end
  end

  # GET /currencies/EUR or /currencies/EUR.json
  def show
    @currency = Currency.find(params[:id])
  end

  # GET /currencies/followed
  def followed
    user = current_user

    @currencies = CurrencyFollowing.where(follower_email: user.email)
      .map { |following| following.followed_currency }
    @hide_follows = true
  end

  # GET /currencies/all or /currencies/all.json
  def all
    @currencies = Currency.all
  end

  # PUT /currencies/EUR/follow
  def follow
    user = current_user
    currency = Currency.find(params[:currency_id])

    CurrencyFollowerManager.call user: user, currency: currency, follow: true

    redirect_back fallback_location: currencies_path
  end

  # DELETE /currencies/EUR/follow
  def unfollow
    user = current_user
    currency = Currency.find(params[:currency_id])

    CurrencyFollowerManager.call user: user, currency: currency, follow: false

    redirect_back fallback_location: currencies_path
  end

end
