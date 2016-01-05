FactoryGirl.define do
  factory :state do
    name Faker::Address.state
    abbr Faker::Address.state_abbr
  end
end
