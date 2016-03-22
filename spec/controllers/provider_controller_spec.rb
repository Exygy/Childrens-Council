require 'rails_helper'

RSpec.describe Api::ProvidersController, type: :controller do
  describe 'POST #index' do
    context 'when parent saved' do
      pending
      # let(:parent_attributes) { FactoryGirl.attributes_for :parent }
      # before do
      #   post :search, { parent: parent_attributes }, format: :json
      # end

      # it 'returns json for new record' do
      #   parent_response = JSON.parse(response.body, symbolize_names: true)
      #   expect(parent_response[:email]).to eql parent_attributes[:email]
      # end

      # it { is_expected.to respond_with 200 }
    end

    context 'when parent not saved' do
      pending
      # before do
      #   invalid_parent_attributes = { first_name: 'Jane' } # missing last_name
      #   post :search, { parent: invalid_parent_attributes }, format: :json
      # end

      # it 'returns errors' do
      #   parent_response = JSON.parse(response.body, symbolize_names: true)
      #   expect(parent_response).to have_key(:errors)
      # end

      # it 'renders errors with reason' do
      #   parent_response = JSON.parse(response.body, symbolize_names: true)
      #   expect(parent_response[:errors][:last_name]).to include "can't be blank"
      # end

      # it { is_expected.to respond_with 422 }
    end
  end
end
