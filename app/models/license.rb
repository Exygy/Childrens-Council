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
