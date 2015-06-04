class RenameCategoriesToCategoryOnIngredients < ActiveRecord::Migration
  def change
    rename_column :ingredients, :categories, :category
  end
end
