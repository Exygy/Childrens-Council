FactoryGirl.define do
  factory :neighborhood do
    name Faker::Address.street_name
  end
end
