# == Schema Information
#
# Table name: providers
#
#  id              :integer          not null, primary key
#  name            :text             not null
#  alternate_name  :text
#  contact_name    :text
#  phone           :text
#  phone_ext       :text
#  phone_other     :text
#  phone_other_ext :text
#  fax             :text
#  email           :text
#  url             :text
#  address_1       :text
#  address_2       :text
#  city_id         :integer
#  state_id        :integer
#  zip             :text
#  cross_street_1  :text
#  cross_street_2  :text
#  mail_address_1  :text
#  mail_address_2  :text
#  mail_city_id    :integer
#  mail_state_id   :integer
#  mail_zip        :text
#  ssn             :text
#  tax_id          :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  latitude        :float
#  longitude       :float
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
  it { is_expected.to belong_to(:city) }
  it { is_expected.to belong_to(:mail_city).class_name('City').with_foreign_key('mail_city_id') }
  it { is_expected.to belong_to(:state) }
  it { is_expected.to belong_to(:mail_state).class_name('State').with_foreign_key('mail_state_id') }
  it { is_expected.to belong_to(:zip_code) }
  it { is_expected.to belong_to(:mail_zip_code).class_name('ZipCode').with_foreign_key('mail_zip_code_id') }
  it { is_expected.to have_many(:licenses) }
  it { is_expected.to belong_to(:schedule_year) }
  it { is_expected.to have_and_belong_to_many(:schedule_week) }
  it { is_expected.to have_many(:schedule_hours) }
  it { is_expected.to have_many(:schedule_days) }
  it { expect(provider.latitude).to eq(40.7143528) }
  it { expect(provider.longitude).to eq(-74.0059731) }
end
