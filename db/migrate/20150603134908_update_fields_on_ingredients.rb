class UpdateFieldsOnIngredients < ActiveRecord::Migration
  def change
    rename_column :ingredients, :location, :categories
    add_column :ingredients, :unit_of_measurement, :string
  end
end
