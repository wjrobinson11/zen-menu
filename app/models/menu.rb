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

class Menu < ActiveRecord::Base
  serialize :breakfast_recipe_ids
  serialize :lunch_recipe_ids
  serialize :dinner_recipe_ids

  validate :serve_date, presence: true

  after_initialize :set_defaults

  def breakfast_recipes
    Recipe.where('id in (?)', breakfast_recipe_ids).sort
  end

  def dinner_recipes
    Recipe.where('id in (?)', dinner_recipe_ids).sort
  end

  def format_breakfast_time
    breakfast_time.strftime('%k:%M') if breakfast_time
  end

  def format_dinner_time
    dinner_time.strftime('%k:%M') if dinner_time
  end

  def format_lunch_time
    lunch_time.strftime('%k:%M') if lunch_time
  end

  def lunch_recipes
    Recipe.where('id in (?)', lunch_recipe_ids).sort
  end

  def recipe_ids
    (breakfast_recipe_ids + lunch_recipe_ids + dinner_recipe_ids).uniq.compact
  end

  def recipes
    Recipe.where('id in (?)', recipe_ids).sort
  end

  private

  def set_defaults
    self.breakfast_time ||= Time.new(2000, 01, 01, 8, 15)
    self.lunch_time     ||= Time.new(2000, 01, 01, 12, 30)
    self.dinner_time    ||= Time.new(2000, 01, 01, 18, 30)
    self.breakfast_head_count ||= 0
    self.lunch_head_count     ||= 0
    self.dinner_head_count    ||= 0
    self.breakfast_recipe_ids ||= []
    self.lunch_recipe_ids     ||= []
    self.dinner_recipe_ids    ||= []
  end
end
