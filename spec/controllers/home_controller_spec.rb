require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #wordpress_template' do
    it 'returns http success' do
      get :wordpress_template
      expect(response).to have_http_status(:success)
    end
  end
end
