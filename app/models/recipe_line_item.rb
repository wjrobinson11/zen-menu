# == Schema Information
#
# Table name: recipe_line_items
#
#  created_at    :datetime
#  id            :integer          not null, primary key
#  ingredient_id :integer
#  quantity      :integer
#  recipe_id     :integer
#  updated_at    :datetime
#

class RecipeLineItem < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :recipe
end
