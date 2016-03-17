# == Schema Information
#
# Table name: programs
#
#  id   :integer          not null, primary key
#  name :text             not null
#

FactoryGirl.define do
  factory :program do
    name Faker::Company.catch_phrase
  end
end
