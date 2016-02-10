class CareType < ActiveRecord::Base
  validates :name, presence: true
  has_many :providers
  has_and_belongs_to_many :children
end
