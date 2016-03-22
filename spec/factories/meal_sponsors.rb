# == Schema Information
#
# Table name: meal_sponsors
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :meal_sponsor do
    name Faker::Company.name
  end
end
