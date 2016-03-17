# == Schema Information
#
# Table name: providers
#
#  id                  :integer          not null, primary key
#  name                :text             not null
#  alternate_name      :text
#  contact_name        :text
#  phone               :text
#  phone_ext           :text
#  phone_other         :text
#  phone_other_ext     :text
#  fax                 :text
#  email               :text
#  url                 :text
#  address_1           :text
#  address_2           :text
#  city_id             :integer
#  state_id            :integer
#  cross_street_1      :text
#  cross_street_2      :text
#  mail_address_1      :text
#  mail_address_2      :text
#  mail_city_id        :integer
#  mail_state_id       :integer
#  ssn                 :text
#  tax_id              :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  latitude            :float
#  longitude           :float
#  schedule_year_id    :integer
#  zip_code_id         :integer
#  care_type_id        :integer
#  description         :text
#  licensed_ages       :integer          default([]), is an Array
#  neighborhood_id     :integer
#  mail_zip_code       :string
#  accepting_referrals :boolean
#
# Indexes
#
#  index_providers_on_care_type_id      (care_type_id)
#  index_providers_on_city_id           (city_id)
#  index_providers_on_mail_city_id      (mail_city_id)
#  index_providers_on_mail_state_id     (mail_state_id)
#  index_providers_on_neighborhood_id   (neighborhood_id)
#  index_providers_on_schedule_year_id  (schedule_year_id)
#  index_providers_on_state_id          (state_id)
#  index_providers_on_zip_code_id       (zip_code_id)
#

require 'rails_helper'

RSpec.describe Provider, type: :model do
  let(:provider) { FactoryGirl.build(:provider) }

  subject { provider }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:care_type) }
  it { is_expected.to belong_to(:city) }
  it { is_expected.to belong_to(:mail_city).class_name('City').with_foreign_key('mail_city_id') }
  it { is_expected.to belong_to(:state) }
  it { is_expected.to belong_to(:mail_state).class_name('State').with_foreign_key('mail_state_id') }
  it { is_expected.to belong_to(:zip_code) }
  it { is_expected.to have_many(:licenses) }
  it { is_expected.to belong_to(:neighborhood) }
  it { is_expected.to belong_to(:schedule_year) }
  it { is_expected.to have_and_belong_to_many(:schedule_week) }
  it { is_expected.to have_many(:schedule_hours) }
  it { is_expected.to have_many(:schedule_days) }
  it { is_expected.to have_many(:language_providers) }
  it { is_expected.to have_many(:languages) }
  it { is_expected.to have_one(:status) }
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

  describe '.search_by_zipcode_ids' do
    let!(:first_zip_code) { FactoryGirl.create(:zip_code) }
    let!(:second_zip_code) { FactoryGirl.create(:zip_code) }
    let!(:first_provider) { FactoryGirl.create(:provider, zip_code: first_zip_code) }
    let!(:second_provider) { FactoryGirl.create(:provider, zip_code: second_zip_code) }
    let!(:third_provider) { FactoryGirl.create(:provider, zip_code: second_zip_code) }

    it 'returns providers filtered by zip codes' do
      expect(Provider.search_by_zipcode_ids([first_zip_code.id]).count).to be 1
      expect(Provider.search_by_zipcode_ids([second_zip_code.id]).count).to be 2
      expect(Provider.search_by_zipcode_ids([first_zip_code.id, second_zip_code.id]).count).to be 3
    end
  end

  describe '.search_by_neighborhood_ids' do
    let!(:first_neighborhood) { FactoryGirl.create(:neighborhood) }
    let!(:second_neighborhood) { FactoryGirl.create(:neighborhood) }
    let!(:first_provider) { FactoryGirl.create(:provider, neighborhood: first_neighborhood) }
    let!(:second_provider) { FactoryGirl.create(:provider, neighborhood: second_neighborhood) }
    let!(:third_provider) { FactoryGirl.create(:provider, neighborhood: second_neighborhood) }

    it 'returns providers filtered by neighborhoods' do
      expect(Provider.search_by_neighborhood_ids([first_neighborhood.id]).count).to be 1
      expect(Provider.search_by_neighborhood_ids([second_neighborhood.id]).count).to be 2
      expect(Provider.search_by_neighborhood_ids([first_neighborhood.id, second_neighborhood.id]).count).to be 3
    end
  end

  describe '.search_by_schedule_year_ids' do
    let!(:first_schedule_year) { FactoryGirl.create(:schedule_year) }
    let!(:second_schedule_year) { FactoryGirl.create(:schedule_year) }
    let!(:first_provider) { FactoryGirl.create(:provider, schedule_year: first_schedule_year) }
    let!(:second_provider) { FactoryGirl.create(:provider, schedule_year: second_schedule_year) }
    let!(:third_provider) { FactoryGirl.create(:provider, schedule_year: second_schedule_year) }

    it 'returns providers filtered by schedule year' do
      expect(Provider.search_by_schedule_year_ids([first_schedule_year.id]).count).to be 1
      expect(Provider.search_by_schedule_year_ids([second_schedule_year.id]).count).to be 2
      expect(Provider.search_by_schedule_year_ids([first_schedule_year.id, second_schedule_year.id]).count).to be 3
    end
  end

  describe '.search_by_care_type_ids' do
    let!(:first_care_type) { FactoryGirl.create(:care_type) }
    let!(:second_care_type) { FactoryGirl.create(:care_type) }
    let!(:first_provider) { FactoryGirl.create(:provider, care_type: first_care_type) }
    let!(:second_provider) { FactoryGirl.create(:provider, care_type: second_care_type) }
    let!(:third_provider) { FactoryGirl.create(:provider, care_type: second_care_type) }

    it 'returns providers filtered by care type' do
      expect(Provider.search_by_care_type_ids([first_care_type.id]).count).to be 1
      expect(Provider.search_by_care_type_ids([second_care_type.id]).count).to be 2
      expect(Provider.search_by_care_type_ids([first_care_type.id, second_care_type.id]).count).to be 3
    end
  end

  describe '.search_by_ages' do
    let(:one_year_old) { [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12] }
    let(:two_year_old) { [13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24] }
    let(:three_year_old) { [25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36] }
    let!(:first_provider) { FactoryGirl.create(:provider, licensed_ages: one_year_old) }
    let!(:second_provider) { FactoryGirl.create(:provider, licensed_ages: one_year_old + three_year_old) }
    let!(:third_provider) { FactoryGirl.create(:provider, licensed_ages: two_year_old) }

    it 'returns providers filtered by ages' do
      expect(Provider.search_by_ages(one_year_old).count).to be 2
      expect(Provider.search_by_ages(two_year_old).count).to be 1
      expect(Provider.search_by_ages(three_year_old).count).to be 1
    end
  end

  describe '.search_by_languages' do
    let(:first_language) { FactoryGirl.create(:language) }
    let(:second_language) { FactoryGirl.create(:language) }
    let(:first_provider) { FactoryGirl.create(:provider) }
    let(:second_provider) { FactoryGirl.create(:provider) }
    let!(:first_language_provider) { FactoryGirl.create(:language_provider, level: 'fluent', provider: first_provider, language: first_language) }
    let!(:second_language_provider) { FactoryGirl.create(:language_provider, level: 'spoken', provider: first_provider, language: first_language) }
    let!(:third_language_provider) { FactoryGirl.create(:language_provider, level: 'fluent', provider: second_provider, language: first_language) }
    let!(:fourth_language_provider) { FactoryGirl.create(:language_provider, level: 'spoken', provider: second_provider, language: second_language) }

    it 'returns providers filtered by languages' do
      first_search_params = [
        { language_id: first_language.id, level: 'fluent' },
      ]
      second_search_params = [
        { language_id: second_language.id, level: 'spoken' },
      ]
      third_search_params = [
        { language_id: first_language.id, level: 'fluent' },
        { language_id: second_language.id, level: 'fluent' },
      ]
      fourth_search_params = [
        { language_id: first_language.id, level: 'fluent' },
        { language_id: first_language.id, level: 'spoken' },
      ]

      expect(Provider.search_by_languages(first_search_params).count).to be 2
      expect(Provider.search_by_languages(second_search_params).count).to be 1
      expect(Provider.search_by_languages(third_search_params).count).to be 0
      expect(Provider.search_by_languages(fourth_search_params).count).to be 1
    end
  end

  describe '.search_by_days_and_hours' do
    let(:first_schedule_day) { FactoryGirl.create(:schedule_day) }
    let(:second_schedule_day) { FactoryGirl.create(:schedule_day) }
    let(:first_provider) { FactoryGirl.create(:provider) }
    let(:second_provider) { FactoryGirl.create(:provider) }
    let!(:first_schedule_hours) { FactoryGirl.create(:schedule_hours, schedule_day: first_schedule_day, start_time: '08:00:00', end_time: '17:00:00', provider: first_provider) }
    let!(:second_schedule_hours) { FactoryGirl.create(:schedule_hours, schedule_day: second_schedule_day, start_time: '08:00:00', end_time: '17:00:00', provider: first_provider) }
    let!(:third_schedule_hours) { FactoryGirl.create(:schedule_hours, schedule_day: first_schedule_day, start_time: '09:00:00', end_time: '17:00:00', provider: second_provider) }
    let!(:fourth_schedule_hours) { FactoryGirl.create(:schedule_hours, schedule_day: second_schedule_day, start_time: '09:00:00', end_time: '17:00:00', provider: second_provider) }

    it 'returns providers filtered by days and hours' do
      first_search_params = [
        { schedule_day_id: first_schedule_day.id, start_time: '08:00:00', end_time: '17:00:00' },
      ]
      second_search_params = [
        { schedule_day_id: first_schedule_day.id, start_time: '09:00:00', end_time: '17:00:00' },
      ]
      third_search_params = [
        { schedule_day_id: first_schedule_day.id, start_time: '08:00:00', end_time: '17:00:00' },
        { schedule_day_id: second_schedule_day.id, start_time: '09:00:00', end_time: '17:00:00' },
      ]
      fourth_search_params = [
        { schedule_day_id: first_schedule_day.id, start_time: '08:00:00', end_time: '17:00:00' },
        { schedule_day_id: second_schedule_day.id, start_time: '08:00:00', end_time: '17:00:00' },
      ]
      expect(Provider.search_by_days_and_hours(first_search_params).count).to be 1
      expect(Provider.search_by_days_and_hours(second_search_params).count).to be 2
      expect(Provider.search_by_days_and_hours(third_search_params).count).to be 1
      expect(Provider.search_by_days_and_hours(fourth_search_params).count).to be 1
    end
  end
end
