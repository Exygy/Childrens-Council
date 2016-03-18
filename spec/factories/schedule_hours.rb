# == Schema Information
#
# Table name: schedule_hours
#
#  id              :integer          not null, primary key
#  schedule_day_id :integer          not null
#  provider_id     :integer          not null
#  start_time      :time
#  end_time        :time
#  closed          :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  open_24         :boolean          default(FALSE)
#
# Indexes
#
#  index_schedule_hours_on_provider_id_and_schedule_day_id  (provider_id,schedule_day_id)
#  index_schedule_hours_on_schedule_day_id_and_provider_id  (schedule_day_id,provider_id) UNIQUE
#

FactoryGirl.define do
  factory :schedule_hours do
    start_time Faker::Time.forward(1, :morning).strftime('%H:%M')
    end_time Faker::Time.forward(1, :evening).strftime('%H:%M')
    closed Faker::Number.between(0, 1)
  end
end
