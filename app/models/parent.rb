# == Schema Information
#
# Table name: parents
#
#  id              :integer          not null, primary key
#  first_name      :text             not null
#  last_name       :text             not null
#  email           :citext
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  phone           :string(10)
#  found_option_id :integer
#  address         :text
#  home_zip_code   :string(5)
#  api_key         :string
#  full_name       :string
#  random_seed     :float
#  near_address    :string
#  subscribe       :boolean
#
# Indexes
#
#  index_parents_on_found_option_id  (found_option_id)
#

class Parent < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, allow_blank: true
  validates :phone, presence: true, if: 'email.blank?'
  validates :phone, length: { is: 10 }, uniqueness: true, allow_blank: true
  validates :home_zip_code, length: { is: 5 }, allow_blank: true

  has_and_belongs_to_many :care_reasons
  has_and_belongs_to_many :care_types
  accepts_nested_attributes_for :parents_care_reasons, :parents_care_types

  has_many :children
  accepts_nested_attributes_for :children

  belongs_to :found_option, foreign_key: :found_option_id
  has_and_belongs_to_many :neighborhoods
  has_and_belongs_to_many :zip_codes
  before_create :set_api_key
  before_create :set_random_seed

  has_paper_trail

  def phone=(number)
    self[:phone] = number.gsub(/\D/, '') if number
  end

  def full_name=(full_name)
    self[:full_name] = full_name
    full_name_array = full_name.split(' ')
    self[:first_name] = full_name_array[0]
    self[:last_name] = full_name_array[1] if full_name_array.length > 1
  end

  private

  def set_api_key
    self.api_key = Devise.friendly_token.first(20)
  end

  def set_random_seed
    self.random_seed = random_from_range(-1, 1)
  end

  def random_from_range (min, max)
    rand * (max - min) + min
  end
end
