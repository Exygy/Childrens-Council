require 'rails_helper'

RSpec.describe ParentsController, type: :controller do
  describe "POST #create" do
      context "when successfully created" do
        let(:parent_attributes) { FactoryGirl.attributes_for :parent }
        before(:each) do
          post :create, { parent: parent_attributes }, format: :json
        end

        it "returns json for new record" do
          parent_response = JSON.parse(response.body, symbolize_names: true)
          expect(parent_response[:email]).to eql parent_attributes[:email]
        end

        it { is_expected.to respond_with 201 }
      end

      context "when not created" do
        before(:each) do
          invalid_parent_attributes = { first_name: 'Jane' } # missing email
          post :create, { parent: invalid_parent_attributes }, format: :json
        end

        it "returns errors" do
          parent_response = JSON.parse(response.body, symbolize_names: true)
          expect(parent_response).to have_key(:errors)
        end

        it "renders errors with reason" do
          parent_response = JSON.parse(response.body, symbolize_names: true)
          expect(parent_response[:errors][:email]).to include "can't be blank"
        end

        it { should respond_with 422 }
      end
    end

end
