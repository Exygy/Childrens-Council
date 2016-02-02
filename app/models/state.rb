# == Schema Information
#
# Table name: states
#
#  id   :integer          not null, primary key
#  name :text
#  abbr :text
#

class State < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates(
    :abbr,
    presence:   true,
    uniqueness: true,
    length:     { is: 2 },
    format:     { with: /[A-Z]+/, message: 'only allows capital letters' },
  )

  has_many :providers
end
