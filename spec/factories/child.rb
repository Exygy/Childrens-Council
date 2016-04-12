FactoryGirl.define do
  factory :child do
    age_months Faker::Number.between(0, 215)
  end
end
