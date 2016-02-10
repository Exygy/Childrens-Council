# == Schema Information
#
# Table name: zip_codes
#
#  id  :integer          not null, primary key
#  zip :string(5)        not null
#

FactoryGirl.define do
  factory :zip_code do
    zip Faker::Number.number(5)
  end
end
