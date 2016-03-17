# == Schema Information
#
# Table name: providers
#
#  id                  :integer          not null, primary key
#  name                :text             not null
#  alternate_name      :text
#  contact_name        :text
#  phone               :text
#  phone_ext           :text
#  phone_other         :text
#  phone_other_ext     :text
#  fax                 :text
#  email               :text
#  url                 :text
#  address_1           :text
#  address_2           :text
#  city_id             :integer
#  state_id            :integer
#  cross_street_1      :text
#  cross_street_2      :text
#  mail_address_1      :text
#  mail_address_2      :text
#  mail_city_id        :integer
#  mail_state_id       :integer
#  ssn                 :text
#  tax_id              :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  latitude            :float
#  longitude           :float
#  schedule_year_id    :integer
#  zip_code_id         :integer
#  care_type_id        :integer
#  description         :text
#  licensed_ages       :integer          default([]), is an Array
#  neighborhood_id     :integer
#  mail_zip_code       :string
#  accepting_referrals :boolean
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

class Provider < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :care_type
  belongs_to :city
  belongs_to :mail_city, class_name: 'City', foreign_key: :mail_city_id
  belongs_to :state
  belongs_to :mail_state, class_name: 'State', foreign_key: :mail_state_id
  belongs_to :zip_code
  has_many :licenses
  belongs_to :neighborhood
  belongs_to :schedule_year
  has_and_belongs_to_many :schedule_week, join_table: :providers_schedule_week
  has_many :schedule_hours, class_name: 'ScheduleHours'
  has_many :schedule_days, through: :schedule_hours
  has_many :language_providers
  has_many :languages, through: :language_providers
  has_one :status

  has_paper_trail
  geocoded_by :geocodable_address_string
  after_validation :geocode # , if: ->(obj){ obj.address.present? and obj.address_changed? }
  before_save :calculate_ages

  def as_json(options={})
    super(include: :schedule_hours)
  end

  def facility?
    care_type ? care_type.facility : false
  end

  def geocodable_address_string
    full_address_array.flatten.compact.join(', ')
  end

  def full_address_array
    r = []
    r << street_address
    r << city.name if city
    r << state.name if state
    r << zip_code.zip if zip_code
    r
  end

  def street_address
    address_array = []
    # facility are geocoded by exact address
    if self.facility?
      address_array << address_1
      address_array << address_2
    end
    # non facility are geocoded by cross streets
    unless self.facility?
      address_array << cross_street_1
      address_array << '@' # mark street intersection
      address_array << cross_street_2
    end
    address_array.compact
  end

  def calculate_ages
    ages = []
    if licenses.present?
      licenses.each do |license|
        next unless license.age_range

        license.age_range.each do |age|
          ages << age
        end
      end
    end

    self.licensed_ages = ages.uniq
  end

  # CLASS METHODS
  class << self
    def search_by_zipcode_ids(zipcode_ids)
      where { zip_code_id.in(my { zipcode_ids }) }
    end

    def search_by_neighborhood_ids(neighborhoods)
      where { neighborhood_id.in(my { neighborhoods }) }
    end

    def search_by_schedule_year_ids(schedule_year_ids)
      where { schedule_year_id.in(my { schedule_year_ids }) }
    end

    def search_by_care_type_ids(care_type_ids)
      where { care_type_id.in(my { care_type_ids }) }
    end

    def search_by_ages(ages)
      query_param = '{' + ages.join(',') + '}'
      where('licensed_ages @> ?', query_param)
    end

    def search_by_languages(languages)
      query_params = languages_to_query_params(languages)
      valid_languages_size = valid_languages_size(languages)
      results = LanguageProvider.where(
        (
          ['("language_providers"."level" = ? AND "language_providers"."language_id" = ?)'] * valid_languages_size
        ).join(' OR '),
        *query_params,
      )
      results = results.select { language_providers.provider_id }
      results = results.group { language_providers.provider_id }
      results = results.having {
        {
          language_providers => {
            count('*') => my { valid_languages_size }
          }
        }
      }
      where { id.in my { results } }
    end

    def search_by_days_and_hours(days_and_hours)
      query_params = days_and_hours_to_query_params(days_and_hours)
      valid_days_and_hours_size = valid_days_and_hours_size(days_and_hours)
      results = ScheduleHours.where(
        (
          ['("schedule_hours"."start_time" <= ? AND "schedule_hours"."end_time" >= ? AND "schedule_hours"."schedule_day_id" = ?)'] * valid_days_and_hours_size
        ).join(' OR '),
        *query_params,
      )
      results = results.select { schedule_hours.provider_id }
      results = results.group { schedule_hours.provider_id }
      results = results.having {
        {
          schedule_hours => {
            count('*') => my { valid_days_and_hours_size }
          }
        }
      }
      where { id.in my { results } }
    end

    private

    def valid_days_and_hours_size(days_and_hours)
      count = 0
      days_and_hours.each do |day_and_hours|
        next unless valid_day_and_hours?(day_and_hours)
        count += 1
      end
      count
    end

    def days_and_hours_to_query_params(days_and_hours)
      query_params = []
      days_and_hours.each do |day_and_hours|
        next unless valid_day_and_hours?(day_and_hours)
        query_params << day_and_hours[:start_time]
        query_params << day_and_hours[:end_time]
        query_params << day_and_hours[:schedule_day_id]
      end
      query_params
    end

    def valid_day_and_hours?(day_and_hours)
      day_and_hours.key?(:start_time) and
        day_and_hours.key?(:end_time) and
        day_and_hours.key?(:schedule_day_id)
    end

    def valid_languages_size(languages)
      count = 0
      languages.each do |language|
        next unless valid_language?(language)
        count += 1
      end
      count
    end

    def languages_to_query_params(languages)
      query_params = []
      languages.each do |language|
        next unless valid_language?(language)
        query_params << language[:level]
        query_params << language[:language_id]
      end
      query_params
    end

    def valid_language?(language)
      language.key?(:level) and
        language.key?(:language_id)
    end
  end
end
