module Faker
  class PhoneNumber
    def self.us_number
      "#{Faker::PhoneNumber.area_code}-#{Faker::PhoneNumber.exchange_code}-#{Faker::PhoneNumber.subscriber_number}"
    end
  end
end
