# == Schema Information
#
# Table name: status_reasons
#
#  id          :integer          not null, primary key
#  name        :text             not null
#  status_type :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :status_reason do
    name Faker::Lorem.word
    status_type 0
  end
end
