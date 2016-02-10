# == Schema Information
#
# Table name: parents
#
#  id              :integer          not null, primary key
#  first_name      :text             not null
#  last_name       :text             not null
#  email           :citext
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  phone           :string(10)
#  zip_code_id     :integer
#  found_option_id :integer
#
# Indexes
#
#  index_parents_on_found_option_id  (found_option_id)
#  index_parents_on_zip_code_id      (zip_code_id)
#

FactoryGirl.define do
  factory :parent do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.us_number }
  end
end
