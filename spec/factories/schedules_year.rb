# == Schema Information
#
# Table name: schedules_year
#
#  id   :integer          not null, primary key
#  name :text             not null
#

FactoryGirl.define do
  factory :schedule_year do
    name Faker::Hipster.word.capitalize
  end
end
