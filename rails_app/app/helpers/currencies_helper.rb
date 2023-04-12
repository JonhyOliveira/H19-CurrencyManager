# frozen_string_literal: true

module CurrenciesHelper

    def format_currency_ex_rate currency, include_descriptor=false, round=true
        ex_rate = currency.latest_exchange_rate
        based_on = 1

        # if user has a favorite currency display the exchange rate as that currency
        if user_signed_in? && current_user.favorite_currency != nil
            ex_rate /= current_user.favorite_currency.latest_exchange_rate
            
            if round
                ex_rate = ex_rate.round current_user.favorite_currency.decimal_digits
            end

            if ex_rate == 1
                return "#{ex_rate}" + (include_descriptor ? " #{current_user.favorite_currency.name}" : "")
            else
                return "#{ex_rate}" + (include_descriptor ? " #{current_user.favorite_currency.name_plural}" : "")
            end
        # otherwise display it unaffiliated
        else
            return "#{ex_rate}"
        end

    end

end
