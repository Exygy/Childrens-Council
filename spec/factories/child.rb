FactoryGirl.define do
  factory :child do
    age_year Faker::Number.between(1, 17)
    age_month Faker::Number.between(1, 12)
  end
end
