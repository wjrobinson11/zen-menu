class ChangeQuantityDatatypeOnRecipes < ActiveRecord::Migration
  def change
    change_column :recipe_line_items, :quantity,  :float
  end
end
