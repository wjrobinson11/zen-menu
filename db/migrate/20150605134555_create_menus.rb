class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.date :serve_date
      t.time :breakfast_time
      t.time :lunch_time
      t.time :dinner_time
      t.integer :breakfast_head_count
      t.integer :lunch_head_count
      t.integer :dinner_head_count
      t.text :breakfast_recipe_ids
      t.text :dinner_recipe_ids
      t.text :lunch_recipe_ids

      t.timestamps
    end
  end
end
