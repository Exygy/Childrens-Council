# == Schema Information
#
# Table name: meal_types
#
#  id   :integer          not null, primary key
#  name :text             not null
#

FactoryGirl.define do
  factory :meal_type do
    name Faker::Lorem.word
  end
end
