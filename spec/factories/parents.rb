# == Schema Information
#
# Table name: parents
#
#  id                     :integer          not null, primary key
#  first_name             :text
#  last_name              :text
#  email                  :citext
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  phone                  :string(10)
#  found_option_id        :integer
#  address                :text
#  home_zip_code          :string(5)
#  api_key                :string
#  full_name              :string
#  random_seed            :float
#  near_address           :string
#  subscribe              :boolean
#  provider               :string           default("email")
#  uid                    :text             default("")
#  tokens                 :text
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  allow_password_change  :boolean          default(FALSE), not null
#
# Indexes
#
#  index_parents_on_found_option_id   (found_option_id)
#  index_parents_on_uid_and_provider  (uid,provider) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (found_option_id => found_options.id)
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
