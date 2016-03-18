# == Schema Information
#
# Table name: languages
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :language do
    name Faker::Superhero.power
  end
end
