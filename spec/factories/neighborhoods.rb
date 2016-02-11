# == Schema Information
#
# Table name: neighborhoods
#
#  id   :integer          not null, primary key
#  name :text             not null
#

FactoryGirl.define do
  factory :neighborhood do
    name Faker::Address.street_name
  end
end
