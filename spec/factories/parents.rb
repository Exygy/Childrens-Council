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
#  found_option_id :integer
#  address         :text
#  home_zip_code   :string(5)
#  api_key         :string
#  full_name       :string
#  random_seed     :float
#  near_address    :string
#
# Indexes
#
#  index_parents_on_found_option_id  (found_option_id)
#

FactoryGirl.define do
  factory :parent do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email Faker::Internet.email
    phone "#{Faker::PhoneNumber.area_code}-#{Faker::PhoneNumber.exchange_code}-#{Faker::PhoneNumber.subscriber_number}"
    home_zip_code Faker::Number.number(5)
  end
end
