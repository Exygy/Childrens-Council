class ZipCode < ActiveRecord::Base
  validates :zip, presence: true, length: { is: 5 }
  has_many :providers
  has_and_belongs_to_many :parents
end
