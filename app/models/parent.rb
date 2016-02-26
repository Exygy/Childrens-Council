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
#
# Indexes
#
#  index_parents_on_found_option_id  (found_option_id)
#

class Parent < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, if: 'email.present?'
  validates :phone, presence: true, if: 'email.blank?'
  validates :phone, length: { is: 10 }, uniqueness: true, if: 'phone.present?'
  validates :home_zip_code, length: { is: 5 }, if: 'home_zip_code.present?'
  has_and_belongs_to_many :care_reasons
  belongs_to :found_option, foreign_key: :found_option_id
  has_and_belongs_to_many :neighborhoods
  has_and_belongs_to_many :zip_codes
  before_create :set_api_key

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

  def set_api_key
    self.api_key = Devise.friendly_token.first(20)
  end
end
