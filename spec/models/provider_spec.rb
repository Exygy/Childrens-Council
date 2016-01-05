require 'rails_helper'

RSpec.describe Provider, type: :model do
  let(:provider) { FactoryGirl.build(:provider) }
  subject { provider }

  it { is_expected.to validate_presence_of(:name) }
  # it { is_expected.to belong_to(:city) }
  # it { is_expected.to belong_to(:mail_city).class_name('City').with_foreign_key('mail_city_id') }
  it { is_expected.to be_valid }
end
