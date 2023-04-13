class LoadCurrenciesHistoryJob < ApplicationJob
  queue_as :default

  def perform **options

    options[:date_range] ||= (DateTime.now.to_date - 1.day - 1.year)..(DateTime.now.to_date - 1.day)

    Currency.transaction do
      # update record list
      result = FreecurrencyApi.call endpoint: "historical", options: { date_from: options[:date_range].first, date_to: options[:date_range].last }

      unless result.failure?
        result.data.each do | date, records |
          records.each do | currency_code, ex_rate |
            record = CurrencyRecord.find_or_initialize_by record_date: date.to_date, code: currency_code
            record.update latest_exchange_rate: ex_rate
          end
        end
      end

    end
  end
end
