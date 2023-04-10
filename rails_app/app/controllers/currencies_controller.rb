# frozen_string_literal: true

#
# This class controls the /currencies endpoint
#
class CurrenciesController < ApplicationController
  # GET /currencies or /currencies.json
  def index
    @currencies = Currency.all
  end

  # GET /currencies/1 or /currencies/1.json
  def show
    @currency = Currency.find(params[:id])
  end
end
