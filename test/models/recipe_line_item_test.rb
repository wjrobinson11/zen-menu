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

require 'test_helper'

class RecipeLineItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
