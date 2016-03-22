# == Schema Information
#
# Table name: subsidies
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :subsidy do
    name Faker::Company.catch_phrase
  end
end
