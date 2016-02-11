# == Schema Information
#
# Table name: care_types
#
#  id       :integer          not null, primary key
#  name     :text             not null
#  facility :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :care_type do
    name Faker::Commerce.product_name
    facility [true, false].sample
  end
end
