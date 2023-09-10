class DropDescriptionFromCurrency < ActiveRecord::Migration[7.0]
  def change
    remove_column :currencies, :description, type: :text
  end
end
