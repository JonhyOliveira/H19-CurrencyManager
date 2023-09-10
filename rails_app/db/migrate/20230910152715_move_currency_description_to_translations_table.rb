class MoveCurrencyDescriptionToTranslationsTable < ActiveRecord::Migration[7.0]
  def up
    Currency.find_each do |curr|
      Currency::Translation.create(currency_id: curr.id, locale: "en", description: curr.description_in_database)
    end
  end
end
