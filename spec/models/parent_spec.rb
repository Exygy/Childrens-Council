# == Schema Information
#
# Table name: parents
#
#  id         :integer          not null, primary key
#  first_name :text             not null
#  last_name  :text             not null
#  email      :citext
#  zip        :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Parent, type: :model do
  let(:parent) { FactoryGirl.build(:parent) }
  let(:parent_without_email) { FactoryGirl.build(:parent, email: '') }
  let(:parent_without_phone) { FactoryGirl.build(:parent, phone: '') }

  subject { parent }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to be_valid }

  context 'when email is blank' do
    subject { parent_without_phone }

    # Only passes when phone is blank?
    it { is_expected.to validate_presence_of(:phone) }
  end

  describe '.find_unique' do
    name = { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name }
    let(:parent_params) { name.merge(email: Faker::Internet.email, phone: Faker::PhoneNumber.us_number) }
    let(:parent_params_same_name_different_email_and_phone) { name.merge(email: Faker::Internet.email, phone: Faker::PhoneNumber.us_number) }
    let!(:parent) { Parent.create(parent_params) }
    let!(:parent_same_name_different_email_and_phone) { Parent.create(parent_params_same_name_different_email_and_phone) }
    let(:unsaved_parent_params) { FactoryGirl.attributes_for(:parent) }

    it 'finds by email when present' do
      parent = Parent.find_unique(parent_params_same_name_different_email_and_phone).take
      expect(parent.id).to eq parent_same_name_different_email_and_phone.id
    end

    it 'finds by phone when email is empty' do
      parent = Parent.find_unique(parent_params_same_name_different_email_and_phone.except(:email)).take
      expect(parent.id).to eq parent_same_name_different_email_and_phone.id
    end

    it 'raises an exception when no parent is found' do
      expect { Parent.find_unique(unsaved_parent_params) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '.first_or_new' do
    let(:parent_params) { FactoryGirl.attributes_for(:parent) }

    it 'creates new parent when not found' do
      parent = Parent.first_or_new(parent_params)
      expect(parent).to be_instance_of(Parent)
      expect(parent.email).to eql parent_params[:email]
    end
  end
end
