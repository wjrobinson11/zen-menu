# == Schema Information
#
# Table name: ingredients
#
#  category            :string(255)
#  created_at          :datetime
#  id                  :integer          not null, primary key
#  name                :string(255)
#  unit_of_measurement :string(255)
#  updated_at          :datetime
#

require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
