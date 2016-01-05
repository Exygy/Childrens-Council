class Provider < ActiveRecord::Base
  validates :name, presence: true
end
