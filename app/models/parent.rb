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
  validates :phone, length: { is: 10 }

  def phone=(number)
    self[:phone] = number.gsub(/\D/, '') if number
  end

  # This will not find a parent if that parent has an email but an email is not present in the parameters
  # This treats email as a primary key, and prevents someone with the same name but without an email from
  # updating a parent with an email
  def self.find_unique(params)
    if params[:email].present?
      where(email: params[:email])
    else
      # We are sure to return a parent without an email, since this parameter is blank
      where(params)
    end
  end

  def self.first_or_new(params)
    parent = find_unique(params).take
    parent ? parent : new(params)
  end
end
