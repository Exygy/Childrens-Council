# == Schema Information
#
# Table name: providers
#
#  id              :integer          not null, primary key
#  name            :text             not null
#  alternate_name  :text
#  contact_name    :text
#  phone           :text
#  phone_ext       :text
#  phone_other     :text
#  phone_other_ext :text
#  fax             :text
#  email           :text
#  url             :text
#  address_1       :text
#  address_2       :text
#  city_id         :integer
#  state_id        :integer
#  zip             :text
#  cross_street_1  :text
#  cross_street_2  :text
#  mail_address_1  :text
#  mail_address_2  :text
#  mail_city_id    :integer
#  mail_state_id   :integer
#  mail_zip        :text
#  ssn             :text
#  tax_id          :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  latitude        :float
#  longitude       :float
#

FactoryGirl.define do
  factory :provider do
    name Faker::Company.name
    alternate_name Faker::Company.name
    contact_name Faker::Name.name
    phone Faker::PhoneNumber.phone_number
    phone_ext Faker::PhoneNumber.extension
    email Faker::Internet.email
    url Faker::Internet.url
    address_1 Faker::Address.street_address
    address_2 Faker::Address.secondary_address
    cross_street_1 Faker::Address.street_name
    cross_street_2 Faker::Address.street_name
    mail_address_1 Faker::Address.street_address
    mail_address_2 Faker::Address.secondary_address
    ssn "#{Faker::Number.number(3)}-#{Faker::Number.number(2)}-#{Faker::Number.number(3)}"
    tax_id "#{Faker::Number.number(2)}-#{Faker::Number.number(7)}"
  end
end
