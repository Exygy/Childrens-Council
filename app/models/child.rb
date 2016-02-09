# == Schema Information
#
# Table name: children
#
#  id         :integer          not null, primary key
#  age        :integer          not null
#  zip        :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Child < ActiveRecord::Base
  belongs_to :schedule_year
end
