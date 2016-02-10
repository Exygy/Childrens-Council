FactoryGirl.define do
  factory :care_type do
    name Faker::Commerce.product_name
    facility [true, false].sample
  end
end
