# == Schema Information
#
# Table name: providers
#
#  id               :integer          not null, primary key
#  name             :text             not null
#  alternate_name   :text
#  contact_name     :text
#  phone            :text
#  phone_ext        :text
#  phone_other      :text
#  phone_other_ext  :text
#  fax              :text
#  email            :text
#  url              :text
#  address_1        :text
#  address_2        :text
#  city_id          :integer
#  state_id         :integer
#  cross_street_1   :text
#  cross_street_2   :text
#  mail_address_1   :text
#  mail_address_2   :text
#  mail_city_id     :integer
#  mail_state_id    :integer
#  ssn              :text
#  tax_id           :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  latitude         :float
#  longitude        :float
#  schedule_year_id :integer
#  zip_code_id      :integer
#  mail_zip_code_id :integer
#  care_type_id     :integer
#  description      :text
#
# Indexes
#
#  index_providers_on_care_type_id      (care_type_id)
#  index_providers_on_city_id           (city_id)
#  index_providers_on_mail_city_id      (mail_city_id)
#  index_providers_on_mail_state_id     (mail_state_id)
#  index_providers_on_mail_zip_code_id  (mail_zip_code_id)
#  index_providers_on_schedule_year_id  (schedule_year_id)
#  index_providers_on_state_id          (state_id)
#  index_providers_on_zip_code_id       (zip_code_id)
#

require 'rails_helper'

RSpec.describe Provider, type: :model do
  before(:all) do
    @provider = FactoryGirl.build(:provider)
    Geocoder.configure(lookup: :test)
    Geocoder::Lookup::Test.add_stub(
      @provider.geocodable_address_string, [
        {
          'latitude'     => 40.7143528,
          'longitude'    => -74.0059731,
          'address'      => 'New York, NY, USA',
          'state'        => 'New York',
          'state_code'   => 'NY',
          'country'      => 'United States',
          'country_code' => 'US',
        },
      ]
    )
  end

  let(:provider) { @provider }

  subject { provider }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:care_type) }
  it { is_expected.to belong_to(:city) }
  it { is_expected.to belong_to(:mail_city).class_name('City').with_foreign_key('mail_city_id') }
  it { is_expected.to belong_to(:state) }
  it { is_expected.to belong_to(:mail_state).class_name('State').with_foreign_key('mail_state_id') }
  it { is_expected.to belong_to(:zip_code) }
  it { is_expected.to belong_to(:mail_zip_code).class_name('ZipCode').with_foreign_key('mail_zip_code_id') }
  it { is_expected.to have_many(:licenses) }
  it { is_expected.to belong_to(:neighborhood) }
  it { is_expected.to belong_to(:schedule_year) }
  it { is_expected.to have_and_belong_to_many(:schedule_week) }
  it { is_expected.to have_many(:schedule_hours) }
  it { is_expected.to have_many(:schedule_days) }
  it { expect(provider.latitude).to eq(40.7143528) }
  it { expect(provider.longitude).to eq(-74.0059731) }

  describe '.facility?' do
    let!(:facility_care_type) { FactoryGirl.create(:care_type, facility: true) }
    let!(:non_facility_care_type) { FactoryGirl.create(:care_type, facility: false) }
    let(:facility_provider) { FactoryGirl.build(:provider) }
    let(:non_facility_provider) { FactoryGirl.build(:provider) }

    it 'returns whether or not provider is a facility' do
      facility_provider.care_type = facility_care_type
      non_facility_provider.care_type = non_facility_care_type

      expect(facility_provider.facility?).to be true
      expect(non_facility_provider.facility?).to be false
    end
  end
end
