class CreateRecipeLineItems < ActiveRecord::Migration
  def change
    create_table :recipe_line_items do |t|
      t.integer :ingredient_id
      t.integer :recipe_id
      t.integer :quantity

      t.timestamps
    end
  end
end
