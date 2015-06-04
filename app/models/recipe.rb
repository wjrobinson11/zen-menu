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

class Recipe < ActiveRecord::Base
  has_many :recipe_line_items
  has_many :ingredients, 
           :through => :recipe_line_items
  
  accepts_nested_attributes_for :recipe_line_items, 
           :reject_if => :all_blank, 
           :allow_destroy => true
end
