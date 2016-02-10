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
#  zip_code_id     :integer
#  found_option_id :integer
#
# Indexes
#
#  index_parents_on_found_option_id  (found_option_id)
#  index_parents_on_zip_code_id      (zip_code_id)
#

class Parent < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, if: 'email.present?'
  validates :phone, presence: true, if: 'email.blank?'
  validates :phone, length: { is: 10 }, uniqueness: true, if: 'phone.present?'
  has_and_belongs_to_many :care_reasons
  belongs_to :found_option, foreign_key: :found_option_id
  belongs_to :zip_code

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
