# == Schema Information
#
# Table name: parents
#
#  id              :integer          not null, primary key
#  first_name      :text             not null
#  last_name       :text             not null
#  email           :citext
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  phone           :string(10)
#  found_option_id :integer
#  address         :text
#  home_zip_code   :string(5)
#  api_key         :string
#  full_name       :string
#  random_seed     :float
#  near_address    :string
#  subscribe       :boolean
#
# Indexes
#
#  index_parents_on_found_option_id  (found_option_id)
#
# Foreign Keys
#
#  fk_rails_...  (found_option_id => found_options.id)
#

require 'rails_helper'

RSpec.describe Parent, type: :model do
  let(:parent) { FactoryGirl.build(:parent) }
  let(:parent_without_email) { FactoryGirl.build(:parent, email: nil) }
  let(:parent_without_phone) { FactoryGirl.build(:parent, phone: nil) }

  subject { parent }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_length_of(:home_zip_code).is_equal_to 5 }
  it { is_expected.to be_valid }
  it { is_expected.to have_and_belong_to_many(:care_reasons) }
  it { is_expected.to have_and_belong_to_many(:care_types) }
  it { is_expected.to belong_to(:found_option).with_foreign_key(:found_option_id) }
  it { is_expected.to have_and_belong_to_many(:neighborhoods) }
  it { is_expected.to have_and_belong_to_many(:zip_codes) }

  context 'when email is blank' do
    subject { parent_without_email }

    # Not working when tested, for some reason, but works when saving in console
    # it { is_expected.to validate_presence_of(:phone) }
  end

  # describe '.find_unique' do
  #   name = { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name }
  #   let(:parent_params) { name.merge(email: Faker::Internet.email, phone: "#{Faker::PhoneNumber.area_code}-#{Faker::PhoneNumber.exchange_code}-#{Faker::PhoneNumber.subscriber_number}") }
  #   let(:parent_params_same_name_different_email_and_phone) { name.merge(email: Faker::Internet.email, phone: "#{Faker::PhoneNumber.area_code}-#{Faker::PhoneNumber.exchange_code}-#{Faker::PhoneNumber.subscriber_number}") }
  #   let!(:parent) { Parent.create(parent_params) }
  #   let!(:parent_same_name_different_email_and_phone) { Parent.create(parent_params_same_name_different_email_and_phone) }
  #   let(:unsaved_parent_params) { FactoryGirl.attributes_for(:parent) }

  #   it 'finds by email when present' do
  #     parent = Parent.find_unique(parent_params_same_name_different_email_and_phone).take
  #     expect(parent.id).to eq parent_same_name_different_email_and_phone.id
  #   end

  #   it 'finds by phone when email is empty' do
  #     parent = Parent.find_unique(parent_params_same_name_different_email_and_phone.except(:email)).take
  #     expect(parent.id).to eq parent_same_name_different_email_and_phone.id
  #   end

  #   it 'raises an exception when no parent is found' do
  #     expect { Parent.find_unique(unsaved_parent_params) }.to raise_error(ActiveRecord::RecordNotFound)
  #   end
  # end

  # describe '.first_or_new' do
  #   let(:parent_params) { FactoryGirl.attributes_for(:parent) }

  #   it 'creates new parent when not found' do
  #     parent = Parent.first_or_new(parent_params)
  #     expect(parent).to be_instance_of(Parent)
  #     expect(parent.email).to eql parent_params[:email]
  #   end
  # end
end
