# == Schema Information
#
# Table name: providers
#
#  id                    :integer          not null, primary key
#  name                  :text             not null
#  alternate_name        :text
#  contact_name          :text
#  phone                 :text
#  phone_ext             :text
#  phone_other           :text
#  phone_other_ext       :text
#  fax                   :text
#  email                 :text
#  url                   :text
#  address_1             :text
#  address_2             :text
#  city_id               :integer
#  state_id              :integer
#  cross_street_1        :text
#  cross_street_2        :text
#  mail_address_1        :text
#  mail_address_2        :text
#  mail_city_id          :integer
#  mail_state_id         :integer
#  ssn                   :text
#  tax_id                :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  latitude              :float
#  longitude             :float
#  schedule_year_id      :integer
#  zip_code_id           :integer
#  care_type_id          :integer
#  description           :text
#  licensed_ages         :integer          default([]), is an Array
#  neighborhood_id       :integer
#  mail_zip_code         :string
#  accepting_referrals   :boolean          default(TRUE)
#  meals_optional        :boolean          default(TRUE)
#  meal_sponsor_id       :integer
#  english_capability    :integer
#  preferred_language_id :integer
#
# Indexes
#
#  index_providers_on_care_type_id           (care_type_id)
#  index_providers_on_city_id                (city_id)
#  index_providers_on_mail_city_id           (mail_city_id)
#  index_providers_on_mail_state_id          (mail_state_id)
#  index_providers_on_meal_sponsor_id        (meal_sponsor_id)
#  index_providers_on_neighborhood_id        (neighborhood_id)
#  index_providers_on_preferred_language_id  (preferred_language_id)
#  index_providers_on_schedule_year_id       (schedule_year_id)
#  index_providers_on_state_id               (state_id)
#  index_providers_on_zip_code_id            (zip_code_id)
#

class ProviderSerializer < ActiveModel::Serializer
  attributes :id, :name, :alternate_name, :contact_name, :phone, :phone_ext
  attributes :phone_other, :phone_other_ext, :fax, :email, :url, :address_1
  attributes :address_2, :city_id, :state_id, :cross_street_1, :cross_street_2
  attributes :mail_address_1, :mail_address_2, :mail_city_id, :mail_state_id
  attributes :ssn, :tax_id, :created_at, :updated_at, :latitude, :longitude
  attributes :schedule_year_id, :zip_code_id, :care_type_id, :description
  attributes :licensed_ages, :neighborhood_id, :mail_zip_code

  attributes :schedule_days, :schedule_hours
  attributes :languages, :licenses

  has_many :languages
  has_many :licenses
  has_many :programs
  has_many :schedule_hours
  has_many :schedule_weeks
  has_many :subsidies
end
