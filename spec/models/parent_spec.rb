require 'rails_helper'

RSpec.describe Parent, type: :model do
  let(:parent) { FactoryGirl.build(:parent) }

  subject { parent }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to be_valid }

  describe '.find_unique' do
    let(:name) { { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name } }
    let(:parent_params) { name.merge(email: Faker::Internet.email) }
    let(:parent_params_same_name_different_email) { name.merge(email: Faker::Internet.email) }
    let(:parent_params_same_name_without_email) { name.merge(email: '') }
    let!(:parent) { Parent.create(parent_params) }
    let!(:parent_same_name_different_email) { Parent.create(parent_params_same_name_different_email) }
    let!(:parent_same_name_without_email) { Parent.create(parent_params_same_name_without_email) }

    it 'finds by email when present' do
      parent = Parent.find_unique(parent_params_same_name_different_email).take
      expect(parent.id).to eq parent_same_name_different_email.id
    end

    it 'finds by name and empty email' do
      parent = Parent.find_unique(parent_params_same_name_without_email).take
      expect(parent.id).to eq parent_same_name_without_email.id
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
