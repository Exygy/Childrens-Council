# == Schema Information
#
# Table name: meal_sponsors
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MealSponsor < ActiveRecord::Base
  validates :name, presence: true

  has_many :providers
end
