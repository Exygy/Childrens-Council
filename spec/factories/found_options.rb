# == Schema Information
#
# Table name: found_options
#
#  id   :integer          not null, primary key
#  name :text             not null
#

FactoryGirl.define do
  factory :found_option do
    name Faker::Lorem.sentence
  end
end
