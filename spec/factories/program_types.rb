# == Schema Information
#
# Table name: program_types
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :program_type do
    name Faker::Company.buzzword
  end
end
