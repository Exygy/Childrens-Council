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

class Parent < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :trackable, :validatable, :registerable
  include DeviseTokenAuth::Concerns::User

  validates :email, uniqueness: { case_sensitive: false }, allow_blank: true
  validates :phone, presence: true, if: 'email.blank?'
  validates :phone, length: { is: 10 }, uniqueness: true, allow_blank: true
  validates :home_zip_code, length: { is: 5 }, allow_blank: true

  has_and_belongs_to_many :care_reasons
  has_and_belongs_to_many :care_types
  accepts_nested_attributes_for :parents_care_reasons, :parents_care_types

  has_many :children
  accepts_nested_attributes_for :children
  has_many :favorites
  has_many :referral_logs

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

  def as_json(options=nil)
    attrs = {
      only: [
        :id,
        :email,
        :phone,
        :first_name,
        :last_name,
        :api_key,
        :home_zip_code
      ],
      methods: [:full_name, :last_search]
    }
    super (attrs.merge(options || {}))
  end

  def last_search
    referral_logs.last_search.params.except('format', 'action', 'controller') if referral_logs.present?
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
