class Neighborhood < ActiveRecord::Base
  validates :name, presence: true
  has_and_belongs_to_many :parents
  has_many :providers
end
