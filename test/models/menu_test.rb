# == Schema Information
#
# Table name: menus
#
#  breakfast_head_count :integer
#  breakfast_recipe_ids :text
#  breakfast_time       :time
#  created_at           :datetime
#  dinner_head_count    :integer
#  dinner_recipe_ids    :text
#  dinner_time          :time
#  id                   :integer          not null, primary key
#  lunch_head_count     :integer
#  lunch_recipe_ids     :text
#  lunch_time           :time
#  serve_date           :date
#  updated_at           :datetime
#

require 'test_helper'

class MenuTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
