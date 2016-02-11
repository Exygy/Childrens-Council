# == Schema Information
#
# Table name: zip_codes
#
#  id  :integer          not null, primary key
#  zip :string(5)        not null
#

class ZipCode < ActiveRecord::Base
  validates :zip, presence: true, length: { is: 5 }
  has_many :providers
  has_and_belongs_to_many :parents
end
