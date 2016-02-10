class ZipCode < ActiveRecord::Base
  validates :zip, presence: true, length: { is: 5 }
  has_many :providers
  has_many :parents
end
