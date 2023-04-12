# frozen_string_literal: true

json.data json.array! @currencies, partial: "currencies/currency", as: :currency
