# == Schema Information
#
# Table name: cities
#
#  id   :integer          not null, primary key
#  name :text             not null
#

FactoryGirl.define do
  factory :city do
    name Faker::Address.city
  end
end
