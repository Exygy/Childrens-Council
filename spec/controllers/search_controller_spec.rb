require 'rails_helper'

RSpec.describe Api::SearchController, type: :controller do
  describe "POST #search" do
      context "when successfully created" do
        let(:parent_attributes) { FactoryGirl.attributes_for :parent }
        before do
          post :search, { parent: parent_attributes }, format: :json
        end

        it "returns json for new record" do
          parent_response = JSON.parse(response.body, symbolize_names: true)
          expect(parent_response[:email]).to eql parent_attributes[:email]
        end

        it { is_expected.to respond_with 200 }
      end

      context "access existing record" do
        let(:email) { 'fred.flintstone@cartoons.com' }
        let(:first_name) { 'Fred' }
        before { FactoryGirl.create(:parent, {email: email}) }

        it "returns existing record" do
          post :search, { parent: {email: email} }, format: :json
          parent_response = JSON.parse(response.body, symbolize_names: true)
          expect(parent_response[:email]).to eql email
        end

        it "updates existing record" do
          post :search, { parent: {email: email, first_name: first_name} }, format: :json
          parent_response = JSON.parse(response.body, symbolize_names: true)
          expect(parent_response[:first_name]).to eql first_name
          expect(response.status).to eql 200
        end

        it "returns success response" do
          post :search, { parent: {email: email} }, format: :json
          expect(response.status).to eql 200
        end
      end

      context "when not created" do
        before do
          invalid_parent_attributes = { first_name: 'Jane' } # missing last_name
          post :search, { parent: invalid_parent_attributes }, format: :json
        end

        it "returns errors" do
          parent_response = JSON.parse(response.body, symbolize_names: true)
          expect(parent_response).to have_key(:errors)
        end

        it "renders errors with reason" do
          parent_response = JSON.parse(response.body, symbolize_names: true)
          expect(parent_response[:errors][:last_name]).to include "can't be blank"
        end

        it { is_expected.to respond_with 422 }
      end
    end

end
