class Parent < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true

  def self.first_or_new(params)
    if params[:email]
      parent = self.where({email: params[:email]}).first
    else
      parent = self.where({first_name: params[:first_name], last_name: params[:last_name]}).first
    end

    parent ? parent : self.new(params)
  end
end
