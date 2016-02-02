# == Schema Information
#
# Table name: parents
#
#  id         :integer          not null, primary key
#  first_name :text             not null
#  last_name  :text             not null
#  email      :citext
#  zip        :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :parent do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
  end
end
