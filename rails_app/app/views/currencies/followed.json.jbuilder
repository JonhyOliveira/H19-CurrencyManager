# frozen_string_literal: true

json.data json.array! @currencies, partial: "currencies/currency", as: :currency

if user_signed_in? && current_user.favorite_currency != nil
    json.based_on current_user.favorite_currency, partial: "currencies/currency"
end