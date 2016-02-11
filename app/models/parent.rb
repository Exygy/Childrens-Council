# == Schema Information
#
# Table name: parents
#
#  id         :integer          not null, primary key
#  first_name :text             not null
#  last_name  :text             not null
#  email      :citext
#  zip        :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
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
  has_and_belongs_to_many :zip_codes

  has_paper_trail

  def phone=(number)
    self[:phone] = number.gsub(/\D/, '') if number
  end

  def self.find_unique(params)
    if params[:email].present?
      parent = where(email: params[:email])
    elsif params[:phone].present?
      parent = where(phone: params[:phone].gsub(/\D/, ''))
    end

    unless parent.present?
      fail ActiveRecord::RecordNotFound, "Can't find parent with params: #{params}"
    end
    parent
  end

  def self.first_or_new(params)
    find_unique(params).take
  rescue ActiveRecord::RecordNotFound
    new(params)
  end
end
