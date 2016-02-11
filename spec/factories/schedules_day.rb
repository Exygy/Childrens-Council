# == Schema Information
#
# Table name: schedules_day
#
#  id   :integer          not null, primary key
#  name :text             not null
#

FactoryGirl.define do
  factory :schedule_day do
    name Date::DAYNAMES.sample
  end
end
