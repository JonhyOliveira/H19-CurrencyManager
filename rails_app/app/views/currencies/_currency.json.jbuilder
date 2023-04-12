# frozen_string_literal: true

json.extract! currency, :id, :symbol, :created_at, :updated_at
json.url currency_url(currency, format: :json)
json.latest_exchange_rate (format_currency_ex_rate currency).to_f