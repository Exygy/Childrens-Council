# == Schema Information
#
# Table name: licenses
#
#  id               :integer          not null, primary key
#  provider_id      :integer          not null
#  date             :date
#  exempt           :boolean
#  license_type     :integer
#  number           :text
#  capacity         :integer
#  capacity_desired :integer
#  capacity_subsidy :integer
#  age_from_year    :integer
#  age_from_month   :integer
#  age_to_year      :integer
#  age_to_month     :integer
#  vacancies        :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_licenses_on_provider_id  (provider_id)
#

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
