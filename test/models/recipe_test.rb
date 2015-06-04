# == Schema Information
#
# Table name: recipes
#
#  created_at   :datetime
#  id           :integer          not null, primary key
#  name         :string(255)
#  notes        :text
#  serving_size :integer
#  updated_at   :datetime
#

require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
