# == Schema Information
#
# Table name: rates
#
#  id           :integer          not null, primary key
#  provider_id  :integer          not null
#  rate_type    :integer          not null
#  full_monthly :decimal(7, 2)
#  full_weekly  :decimal(7, 2)
#  full_daily   :decimal(7, 2)
#  full_hourly  :decimal(7, 2)
#  part_monthly :decimal(7, 2)
#  part_weekly  :decimal(7, 2)
#  part_daily   :decimal(7, 2)
#  part_hourly  :decimal(7, 2)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_rates_on_provider_id  (provider_id)
#

FactoryGirl.define do
  factory :rate do
    association :provider
    rate_type Faker::Number.between(0, 2)
    full_monthly Faker::Commerce.price
    full_weekly Faker::Commerce.price
    full_daily Faker::Commerce.price
    full_hourly Faker::Commerce.price
    part_monthly Faker::Commerce.price
    part_weekly Faker::Commerce.price
    part_daily Faker::Commerce.price
    part_hourly Faker::Commerce.price
  end
end
