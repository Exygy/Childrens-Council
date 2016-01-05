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
    zip Faker::Address.zip
    cross_street_1 Faker::Address.street_name
    cross_street_2 Faker::Address.street_name
    mail_address_1 Faker::Address.street_address
    mail_address_2 Faker::Address.secondary_address
    mail_zip Faker::Address.zip
    ssn "#{Faker::Number.number(3)}-#{Faker::Number.number(2)}-#{Faker::Number.number(3)}"
    tax_id "#{Faker::Number.number(2)}-#{Faker::Number.number(7)}"
    # association :city
  end
end
