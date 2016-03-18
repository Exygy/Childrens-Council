# == Schema Information
#
# Table name: languages
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :language do
    name 'English'
  end

end
