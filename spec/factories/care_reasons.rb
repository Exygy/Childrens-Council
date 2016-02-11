# == Schema Information
#
# Table name: care_reasons
#
#  id   :integer          not null, primary key
#  name :text             not null
#

FactoryGirl.define do
  factory :care_reason do
    name Faker::Commerce.product_name
  end
end
