# == Schema Information
#
# Table name: providers
#
#  id               :integer          not null, primary key
#  name             :text             not null
#  alternate_name   :text
#  contact_name     :text
#  phone            :text
#  phone_ext        :text
#  phone_other      :text
#  phone_other_ext  :text
#  fax              :text
#  email            :text
#  url              :text
#  address_1        :text
#  address_2        :text
#  city_id          :integer
#  state_id         :integer
#  cross_street_1   :text
#  cross_street_2   :text
#  mail_address_1   :text
#  mail_address_2   :text
#  mail_city_id     :integer
#  mail_state_id    :integer
#  ssn              :text
#  tax_id           :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  latitude         :float
#  longitude        :float
#  schedule_year_id :integer
#  zip_code_id      :integer
#  care_type_id     :integer
#  description      :text
#  ages             :integer          default([]), is an Array
#  neighborhood_id  :integer
#  mail_zip_code    :string
#
# Indexes
#
#  index_providers_on_care_type_id      (care_type_id)
#  index_providers_on_city_id           (city_id)
#  index_providers_on_mail_city_id      (mail_city_id)
#  index_providers_on_mail_state_id     (mail_state_id)
#  index_providers_on_neighborhood_id   (neighborhood_id)
#  index_providers_on_schedule_year_id  (schedule_year_id)
#  index_providers_on_state_id          (state_id)
#  index_providers_on_zip_code_id       (zip_code_id)
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
    mail_zip_code Faker::Address.zip_code
    ssn "#{Faker::Number.number(3)}-#{Faker::Number.number(2)}-#{Faker::Number.number(3)}"
    tax_id "#{Faker::Number.number(2)}-#{Faker::Number.number(7)}"

    after(:build) do |provider|
      Geocoder.configure(lookup: :test)
      Geocoder::Lookup::Test.add_stub(
        provider.geocodable_address_string, [
          {
            'latitude'     => 40.7143528,
            'longitude'    => -74.0059731,
            'address'      => 'New York, NY, USA',
            'state'        => 'New York',
            'state_code'   => 'NY',
            'country'      => 'United States',
            'country_code' => 'US',
          },
        ]
      )
      provider.latitude = 40.7143528
      provider.longitude = -74.0059731
      provider.save
    end
  end
end
