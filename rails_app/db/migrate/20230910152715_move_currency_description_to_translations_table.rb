class MoveCurrencyDescriptionToTranslationsTable < ActiveRecord::Migration[7.0]
  def up
    Currency.find_each do |curr|
      Currency::Translation.create(currency_id: curr.id, locale: "en", description: curr.description_in_database)
    end
  end

  def down
    Currency::Translation.where(locale: "en").find_each do |curr_translation|
      Currency.find(curr_translation.currency_id).update_column :description, curr_translation.description
    end
  end
end
