# == Schema Information
#
# Table name: providers
#
#  id              :integer          not null, primary key
#  name            :text             not null
#  alternate_name  :text
#  contact_name    :text
#  phone           :text
#  phone_ext       :text
#  phone_other     :text
#  phone_other_ext :text
#  fax             :text
#  email           :text
#  url             :text
#  address_1       :text
#  address_2       :text
#  city_id         :integer
#  state_id        :integer
#  zip             :text
#  cross_street_1  :text
#  cross_street_2  :text
#  mail_address_1  :text
#  mail_address_2  :text
#  mail_city_id    :integer
#  mail_state_id   :integer
#  mail_zip        :text
#  ssn             :text
#  tax_id          :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  latitude        :float
#  longitude       :float
#

class Provider < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :city
  belongs_to :mail_city, class_name: 'City', foreign_key: :mail_city_id
  belongs_to :state
  belongs_to :mail_state, class_name: 'State', foreign_key: :mail_state_id
  has_many :licenses
  belongs_to :schedule_year
  has_and_belongs_to_many :schedule_week, join_table: 'providers_schedule_week'
  has_many :schedule_hours, class_name: 'ScheduleHours'
  has_many :schedule_days, through: :schedule_hours

  has_paper_trail
  geocoded_by :geocodable_address_string
  after_validation :geocode # , if: ->(obj){ obj.address.present? and obj.address_changed? }

  def facility?
    true
  end

  def geocodable_address_string
    full_address_array.compact.join(', ')
  end

  def full_address_array
    r = []
    r << street_address
    r << city.name if city
    r << state.name if state
    r << zip
    r.flatten
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
end
