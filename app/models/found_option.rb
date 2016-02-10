class FoundOption < ActiveRecord::Base
  validates :name, presence: true
  has_many :parents
end
