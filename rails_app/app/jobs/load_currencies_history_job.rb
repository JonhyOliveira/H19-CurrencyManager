# frozen_string_literal: true
class LoadCurrenciesHistoryJob < ApplicationJob
  queue_as :default

  def perform **options

    options[:date_range] ||= (DateTime.now.to_date - 1.day - 1.week)..(DateTime.now.to_date - 1.day)

    puts options[:date_range]
    
    # update record list
    result = FreecurrencyApi.call endpoint: "historical", options: { date_from: options[:date_range].first, date_to: options[:date_range].last }

    unless result.failure?
      # insert_all ignores conflicts by default (doesn't fail if there is a conflict)
      CurrencyRecord.insert_all result.data.flat_map { |date, incoming_records|
        incoming_records.map { |currency_code, ex_rate|
          { record_date: date.to_date, code: currency_code, latest_exchange_rate: ex_rate }
        }
      }
    end

  end
end
