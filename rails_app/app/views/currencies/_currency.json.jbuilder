# frozen_string_literal: true

json.extract! currency, :id, :symbol, :latest_exchange_rate, :created_at, :updated_at
json.url currency_url(currency, format: :json)
