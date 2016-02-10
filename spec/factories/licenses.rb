FactoryGirl.define do
  factory :license do
    date Faker::Date.backward(730)
    exempt Faker::Number.between(0, 1)
    type Faker::Number.between(0, 3)
    number Faker::Number.number(9)
    capacity Faker::Number.between(2, 20)
    capacity_desired Faker::Number.between(0, 1)
    capacity_subsidy Faker::Number.between(0, 1)
    age_from_year Faker::Number.between(1, 17)
    age_from_month Faker::Number.between(1, 12)
    age_to_year Faker::Number.between(1, 17)
    age_to_month Faker::Number.between(1, 12)
    vacancies Faker::Number.between(2, 20)
  end
end
