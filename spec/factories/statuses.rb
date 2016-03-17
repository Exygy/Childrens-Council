# == Schema Information
#
# Table name: statuses
#
#  id               :integer          not null, primary key
#  provider_id      :integer          not null
#  status_type      :integer          not null
#  start_date       :date
#  end_date         :date
#  status_reason_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_statuses_on_provider_id       (provider_id)
#  index_statuses_on_status_reason_id  (status_reason_id)
#

FactoryGirl.define do
  factory :status do
    status_type Faker::Number.between(0, 2)
    association :provider

    factory :active_status do
      status_type 2
    end

    factory :temporarily_inactive_status do
      status_type 1
      start_date Faker::Date.forward(7)
      end_date Faker::Date.between(1.week.from_now, 1.year.from_now)
    end

    factory :inactive_status do
      status_type 0
      start_date Faker::Date.forward(7)
      association :status_reason
    end
  end
end
