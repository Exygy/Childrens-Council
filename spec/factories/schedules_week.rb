# == Schema Information
#
# Table name: schedules_week
#
#  id      :integer          not null, primary key
#  name    :text             not null
#  tooltip :string
#

FactoryGirl.define do
  factory :schedule_week do
    name Faker::Hipster.word.capitalize
  end
end
