# frozen_string_literal: true

module CurrenciesHelper

  def format_currency_ex_rate(currency, include_descriptor = false, round = true)

    ex_rate = relativize_ex_rate currency, round=round

    # format as a string
    formatted = ex_rate.to_s

    # add the descriptor if needed
    if include_descriptor && user_signed_in? && current_user.favorite_currency != nil
      if ex_rate == 1
        formatted += include_descriptor ? " #{current_user.favorite_currency.name}" : ""
      else
        formatted += include_descriptor ? " #{current_user.favorite_currency.name_plural}" : ""
      end
    end

    return formatted

  end

  def relativize_ex_rate(currency, round = true)

    ex_rate = currency.latest_exchange_rate

    # if the user has a favorite currency display the exchange rate as that currency
    if user_signed_in? && current_user.favorite_currency != nil
      ex_rate = current_user.favorite_currency.latest_exchange_rate / ex_rate
    end

    # round if needed
    if round
      decimal_places = if user_signed_in? && current_user.favorite_currency
        current_user.favorite_currency.decimal_digits
      else
        currency.decimal_digits || 0
      end
      
      ex_rate = ex_rate.round(decimal_places)
      puts "t"
    end

    return ex_rate
  end

  def relativize_record_ex_rate(record)
    ex_rate = record.latest_exchange_rate

    # if the user has a favorite currency get the record for the same date and relativize
    if user_signed_in? && current_user.favorite_currency != nil
      ex_rate = CurrencyRecord.find_by(currency_id: current_user.favorite_currency.id,
        record_date: record.record_date).latest_exchange_rate / ex_rate
    end

    return ex_rate
  end

end
