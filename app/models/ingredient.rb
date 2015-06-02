# == Schema Information
#
# Table name: ingredients
#
#  created_at :datetime
#  id         :integer          not null, primary key
#  location   :string(255)
#  name       :string(255)
#  updated_at :datetime
#

class Ingredient < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :recipe_line_items
  has_many :recipes, :through => :recipe_line_items
end
