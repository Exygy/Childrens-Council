# == Schema Information
#
# Table name: meal_types
#
#  id   :integer          not null, primary key
#  name :text             not null
#

class MealType < ActiveRecord::Base
  validates :name, presence: true

  has_many :meals, inverse_of: :meal_type
end
