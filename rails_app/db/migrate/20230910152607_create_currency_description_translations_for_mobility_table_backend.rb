class CreateCurrencyDescriptionTranslationsForMobilityTableBackend < ActiveRecord::Migration[7.0]
  def change
    create_table :currency_translations do |t|

      # Translated attribute(s)
      t.text :description

      t.string  :locale, null: false
      t.references :currency, null: false, foreign_key: true, index: false, type: :string

      t.timestamps null: false
    end

    add_index :currency_translations, :locale, name: :index_currency_translations_on_locale
    add_index :currency_translations, [:currency_id, :locale], name: :index_currency_translations_on_currency_id_and_locale, unique: true

  end
end
