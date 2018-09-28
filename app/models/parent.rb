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
#  nds_client_uid         :string
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
#  index_parents_on_uid_and_provider  (uid,provider)
#
# Foreign Keys
#
#  fk_rails_...  (found_option_id => found_options.id)
#

class Parent < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :trackable, :registerable
  include DeviseTokenAuth::Concerns::User

  has_many :favorites, -> { order 'favorites.created_at DESC' }
  has_many :referral_logs

  validates :email, uniqueness: { case_sensitive: false }, allow_blank: true, if: '!email.blank?'
  validates :phone, presence: true, if: 'email.blank?'
  validates :phone, length: { is: 10 }, uniqueness: true, allow_blank: true
  validates :home_zip_code, length: { is: 5 }, allow_blank: true

  before_create :set_api_key
  before_create :set_random_seed
  before_save :set_provider

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

  def set_provider
    if email.blank? && phone.present?
      self.provider = 'phone'
      self.uid = phone
    end
  end

  protected

  def password_required?
    return false
  end

  # Allow empty email if phone number is set
  def email_required?
    return false
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
