# == Schema Information
#
# Table name: states
#
#  id   :integer          not null, primary key
#  name :text
#  abbr :text
#

FactoryGirl.define do
  factory :state do
    name Faker::Address.state
    abbr Faker::Address.state_abbr
  end
end
