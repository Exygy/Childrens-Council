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
#

require 'rails_helper'

RSpec.describe Provider, type: :model do
  let(:provider) { FactoryGirl.build(:provider) }
  subject { provider }

  it { is_expected.to validate_presence_of(:name) }
  # it { is_expected.to belong_to(:city) }
  # it { is_expected.to belong_to(:mail_city).class_name('City').with_foreign_key('mail_city_id') }
  it { is_expected.to be_valid }
end
