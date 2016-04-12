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
#  potty_training        :boolean          default(FALSE)
#  co_op                 :boolean          default(FALSE)
#  nutrition_program     :boolean          default(FALSE)
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
  belongs_to :state
  belongs_to :mail_state, class_name: 'State', foreign_key: :mail_state_id
  belongs_to :zip_code
  has_many :licenses
  has_and_belongs_to_many :languages
  belongs_to :preferred_language, class_name: 'Language', foreign_key: :preferred_language_id
  has_many :meals, inverse_of: :provider
  belongs_to :meal_sponsor
  belongs_to :neighborhood
  has_many :rates, inverse_of: :provider
  belongs_to :schedule_year
  has_and_belongs_to_many :schedule_weeks, join_table: :providers_schedule_week
  has_many :schedule_hours, class_name: 'ScheduleHours', inverse_of: :provider
  has_many :schedule_days, through: :schedule_hours
  has_one :status
  has_and_belongs_to_many :subsidies
  has_and_belongs_to_many :programs

  has_paper_trail
  geocoded_by :geocodable_address_string
  after_validation :geocode # , if: ->(obj){ obj.address.present? and obj.address_changed? }
  before_save :calculate_ages

  def as_json(options = {})
    super(include: [:licenses, :schedule_hours, :subsidies])
  end

  def facility?
    care_type ? care_type.facility : false
  end

  # def name
  #   if facility?
  #     super
  #   else
  #     # Get last name and first initial only for family care providers
  #     self[:name].present? ? self[:name][/.+,\s*\w{1}/] + '.' : self[:name]
  #   end
  # end

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

  def meals_included?
    if meals.present?
      meals.each do |meal|
        return true if meal.provided_by_facility
      end
    end

    false
  end

  # CLASS METHODS
  class << self
    def accepting_referrals
      where(accepting_referrals: true)
    end

    def active
      joins(:status).where(status: { status_type: Status.status_types[:active] })
    end

    def listed
      active.accepting_referrals
    end

    def search_by_zip_code_ids(zip_code_ids)
      where { zip_code_id.in(my { zip_code_ids }) }
    end

    def search_by_neighborhood_ids(neighborhoods)
      where { neighborhood_id.in(my { neighborhoods }) }
    end

    def search_by_schedule_year_ids(schedule_year_ids)
      where { schedule_year_id.in(my { schedule_year_ids }) }
    end

    def search_by_schedule_week_ids(schedule_week_ids)
      joins(:schedule_weeks).where(schedule_weeks: { id: schedule_week_ids }).distinct
    end

    def search_by_schedule_day_ids(schedule_day_ids)
      joins(:schedule_hours).where(schedule_hours: { schedule_day_id: schedule_day_ids, closed: false }).distinct
    end

    def search_by_care_type_ids(care_type_ids)
      where { care_type_id.in(my { care_type_ids }) }
    end

    def search_by_program_ids(program_ids)
      joins(:programs).where(programs: { id: program_ids }).distinct
    end

    def search_by_subsidy_ids(subsidy_ids)
      joins(:subsidies).where(subsidies: { id: subsidy_ids }).distinct
    end

    def search_by_ages(ages)
      query_param = '{' + ages.join(',') + '}'
      where('licensed_ages @> ?', query_param)
    end

    def search_by_language_ids(language_ids)
      joins(:languages).where(languages: { id: language_ids }).distinct
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

    def search_by_meals_included(meals_included)
      if meals_included.to_i == 1
        joins(:meals).where(meals: { provided_by_facility: true }).distinct
      else
        provider_ids_with_facility_meals = select(:id).joins(:meals).where(meals: { provided_by_facility: true }).distinct
        joins(:meals).where(meals: { provided_by_facility: false }).where.not(id: provider_ids_with_facility_meals).distinct
      end
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
  end
end
