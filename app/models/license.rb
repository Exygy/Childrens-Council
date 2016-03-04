# == Schema Information
#
# Table name: licenses
#
#  id               :integer          not null, primary key
#  provider_id      :integer          not null
#  date             :date
#  exempt           :boolean
#  license_type     :integer
#  number           :text
#  capacity         :integer
#  capacity_desired :integer
#  capacity_subsidy :integer
#  age_from_year    :integer
#  age_from_month   :integer
#  age_to_year      :integer
#  age_to_month     :integer
#  vacancies        :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_licenses_on_provider_id  (provider_id)
#

class License < ActiveRecord::Base
  enum type: {
    infant: 0,
    preschool: 1,
    school_age: 2,
    fcc: 3,
  }
  validates :age_from_year, inclusion: { in: 1...18 }
  validates :age_to_year, inclusion: { in: 1...18 }
  validates :age_from_month, inclusion: { in: 1..12 }
  validates :age_to_month, inclusion: { in: 1..12 }
  belongs_to :provider
end
