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

class Ingredient < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :category, presence: true
  validates :unit_of_measurement, presence: true

  has_many :recipe_line_items
  has_many :recipes, :through => :recipe_line_items
end
