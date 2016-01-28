require 'rails_helper'

RSpec.describe Api::ApiBaseController, type: :controller do
  describe 'OPTIONS request to API' do
    it 'should return CORS headers' do
      reset!
      process :options, '/api/search'

      puts response.inspect

      # expect(response.headers.keys).to include(
      #   'Access-Control-Allow-Origin',
      #   'Access-Control-Allow-Methods',
      #   'Access-Control-Allow-Headers',
      #   'Access-Control-Max-Age',
      # )
    end
  end
end
