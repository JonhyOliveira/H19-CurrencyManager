# frozen_string_literal: true

#
# This class controls the /currencies endpoint
#
class CurrenciesController < ApplicationController

  before_action :authenticate_user!, only: [:follow, :unfollow, :followed]

  # GET /currencies or /currencies.json
  def index
    puts "signed in = #{user_signed_in?}"

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

    @currencies = user.followed_currencies

    @followed_codes = @currencies.map { |curr| curr.code }
  end

  # GET /currencies/all or /currencies/all.json
  def all
    @currencies = Currency.all

    if user_signed_in?
      user = current_user

      @followed_codes = user.followed_currencies.map { |curr| curr.code }
    end
  end

  # PUT /currencies/EUR/follow
  def follow
    user = current_user
    currency = Currency.find(params[:currency_id])

    handle_result CurrencyFollowerManager.call user: user, currency: currency, follow: true
  end

  # DELETE /currencies/EUR/follow
  def unfollow
    user = current_user
    currency = Currency.find(params[:currency_id])

    handle_result CurrencyFollowerManager.call user: user, currency: currency, follow: false
  end

  #
  # Handles the result of an interactor
  #
  # @param [Context] result the result of the interactor call
  #
  def handle_result(result)

    if result.failure?
      flash[:alert] = result.literal if defined? result.literal

      flash[:alert] = I18n.t(result.message) if defined? result.message
    end

    redirect_back fallback_location: currencies_path
  end

end
