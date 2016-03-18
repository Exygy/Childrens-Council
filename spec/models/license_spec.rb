# == Schema Information
#
# Table name: licenses
#
#  id               :integer          not null, primary key
#  provider_id      :integer          not null
#  date             :date
#  exempt           :boolean          default(FALSE)
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

require 'rails_helper'

RSpec.describe License, type: :model do
  let(:license) { FactoryGirl.build(:license) }

  subject { license }

  it { is_expected.to validate_inclusion_of(:age_from_year).in_range(1...18) }
  it { is_expected.to validate_inclusion_of(:age_to_year).in_range(1...18) }
  it { is_expected.to validate_inclusion_of(:age_to_month).in_range(1..12) }
  it { is_expected.to validate_inclusion_of(:age_to_month).in_range(1..12) }
  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:provider) }

  describe '.age_from_months' do
    pending
  end

  describe '.age_to_months' do
    pending
  end

  describe '.age_range' do
    pending
  end

  private

  describe '.age_in_months(years, months)' do
    pending
  end
end
