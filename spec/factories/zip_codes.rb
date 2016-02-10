FactoryGirl.define do
  factory :zip_code do
    zip Faker::Number.number(5)
  end
end
