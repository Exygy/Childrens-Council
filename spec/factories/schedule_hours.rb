FactoryGirl.define do
  factory :schedule_hours do
    start_time Faker::Time.forward(1, :morning).strftime('%H:%M')
    end_time Faker::Time.forward(1, :evening).strftime('%H:%M')
    closed Faker::Number.between(0, 1)
  end
end
