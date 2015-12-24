class Parent < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true, if: 'email.present?'

  # This will create 2 distinct parents if both have the same first and last name but one does not have an email
  def self.first_or_new(params)
    if params[:email].present?
      parent = self.where({email: params[:email]}).first
    else
      # We are sure to return a parent without an email, since this parameter is blank
      parent = self.where(params).first
    end

    parent ? parent : self.new(params)
  end
end
