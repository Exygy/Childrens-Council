# == Schema Information
#
# Table name: providers
#
#  id                               :integer          not null, primary key
#  name                             :text             not null
#  alternate_name                   :text
#  contact_name                     :text
#  phone                            :text
#  phone_ext                        :text
#  phone_other                      :text
#  phone_other_ext                  :text
#  fax                              :text
#  email                            :text
#  url                              :text
#  address_1                        :text
#  address_2                        :text
#  city_id                          :integer
#  state_id                         :integer
#  cross_street_1                   :text
#  cross_street_2                   :text
#  mail_address_1                   :text
#  mail_address_2                   :text
#  mail_city_id                     :integer
#  mail_state_id                    :integer
#  ssn                              :text
#  tax_id                           :text
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  latitude                         :float
#  longitude                        :float
#  schedule_year_id                 :integer
#  zip_code_id                      :integer
#  care_type_id                     :integer
#  description                      :text
#  licensed_ages                    :integer          default([]), is an Array
#  neighborhood_id                  :integer
#  mail_zip_code                    :string
#  accepting_referrals              :boolean          default(TRUE)
#  meals_optional                   :boolean          default(TRUE)
#  meal_sponsor_id                  :integer
#  english_capability               :integer
#  preferred_language_id            :integer
#  potty_training                   :boolean          default(FALSE)
#  co_op                            :boolean          default(FALSE)
#  nutrition_program                :boolean          default(FALSE)
#  cached_geocodable_address_string :string
#  vacancy                          :integer
#  vacancydate                      :date
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
# Foreign Keys
#
#  fk_rails_...  (city_id => cities.id)
#  fk_rails_...  (mail_city_id => cities.id)
#  fk_rails_...  (mail_state_id => states.id)
#  fk_rails_...  (meal_sponsor_id => meal_sponsors.id)
#  fk_rails_...  (neighborhood_id => neighborhoods.id)
#  fk_rails_...  (preferred_language_id => languages.id)
#  fk_rails_...  (schedule_year_id => schedules_year.id)
#  fk_rails_...  (state_id => states.id)
#  fk_rails_...  (zip_code_id => zip_codes.id)
#

class Provider < ActiveRecord::Base
  enum english_capability: {
    beginning: 0,
    conversational: 1,
    fluent: 2,
    taking_esl: 3,
  }

  validates :name, presence: true

  belongs_to :care_type
  belongs_to :city
  belongs_to :mail_city, class_name: 'City', foreign_key: :mail_city_id
  belongs_to :mail_state, class_name: 'State', foreign_key: :mail_state_id
  belongs_to :meal_sponsor
  belongs_to :neighborhood
  belongs_to :preferred_language, class_name: 'Language', foreign_key: :preferred_language_id
  belongs_to :schedule_year
  belongs_to :state
  belongs_to :zip_code

  has_many :licenses
  has_many :meals, inverse_of: :provider
  has_many :rates, inverse_of: :provider
  has_many :schedule_days, through: :schedule_hours
  has_many :schedule_hours, class_name: 'ScheduleHours', inverse_of: :provider

  has_one :status

  has_and_belongs_to_many :languages
  has_and_belongs_to_many :programs
  has_and_belongs_to_many :schedule_weeks, join_table: :providers_schedule_week
  has_and_belongs_to_many :subsidies

  has_paper_trail
  geocoded_by :geocodable_address_string
  after_validation :geocode # , if: ->(obj){ obj.address.present? and obj.address_changed? }
  before_save :calculate_ages
  before_save :cache_geocodable_address_string

end
