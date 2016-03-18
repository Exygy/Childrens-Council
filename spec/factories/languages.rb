# == Schema Information
#
# Table name: languages
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :language do
    name Faker::Superhero.power
  end
end
