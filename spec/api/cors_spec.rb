require 'rails_helper'

describe 'CORS Preflight Request via OPTIONS HTTP method' do
  before :each do
    @allowed_origin = 'ccsf.wpengine.com'
    @forbidden_origin = 'exygy.com' # <== need to whistlist origin - what origin RSPEC uses
    @allowed_path = '/api/search'
    @forbidden_path = '/api/foo'
  end

  context 'when ORIGIN is specified and resource is allowed' do
    before :each do
      options @allowed_path, {},
              'HTTP_ORIGIN' => @allowed_origin,
              'HTTP_ACCESS_CONTROL_REQUEST_HEADERS' => 'Content-Type',
              'HTTP_ACCESS_CONTROL_REQUEST_METHOD' => 'GET',
              'REQUEST_METHOD' => 'OPTIONS'
    end

    it 'returns a 200 status with no content' do
      expect(response).to have_http_status(200)
      expect(response.body).to eq ''
    end

    it 'sets Access-Control-Allow-Origin header to the Origin in the request' do
      expect(headers['Access-Control-Allow-Origin']).
        to eq(@allowed_origin)
    end

    it 'sets Access-Control-Allow-Methods to the whitelisted methods' do
      allowed_http_methods = headers['Access-Control-Allow-Methods']
      expect(allowed_http_methods).
        to eq(%w(GET POST OPTIONS).join(', '))
    end

    it 'returns the Access-Control-Max-Age header' do
      expect(headers['Access-Control-Max-Age']).to eq('1728000')
    end

    it 'returns the Access-Control-Allow-Credentials header' do
      expect(headers['Access-Control-Allow-Credentials']).to eq('true')
    end

    it 'returns the Access-Control-Allow-Headers header' do
      expect(headers['Access-Control-Allow-Headers']).to eq(
        'Origin, X-Requested-With, Content-Type, Accept, Authorization, X-CSRF-Token'
      )
    end

    it 'only exposes the Etag, Last-Modified, Link and X-Total-Count headers' do
      expect(headers['Access-Control-Expose-Headers']).
        to eq('Etag, Last-Modified, Link, X-Total-Count')
    end

    it 'allows access to a specific provider' do
      options '/api/providers/1', {},
              'HTTP_ORIGIN' => @allowed_origin,
              'HTTP_ACCESS_CONTROL_REQUEST_METHOD' => 'GET',
              'REQUEST_METHOD' => 'OPTIONS'

      expect(headers['Access-Control-Allow-Origin']).
        to eq(@allowed_origin)
    end

    it 'allows access to the search endpoint' do
      options @allowed_path,
              {},
              'HTTP_ORIGIN' => @allowed_origin,
              'HTTP_ACCESS_CONTROL_REQUEST_METHOD' => 'GET',
              'REQUEST_METHOD' => 'OPTIONS'

      expect(headers['Access-Control-Allow-Origin']).
        to eq(@allowed_origin)
    end

    it 'does not allow access to non-whitelisted endpoints' do
      options @forbidden_path, {},
              'HTTP_ORIGIN' => @allowed_origin,
              'HTTP_ACCESS_CONTROL_REQUEST_METHOD' => 'GET',
              'REQUEST_METHOD' => 'OPTIONS'

      expect(headers.keys).not_to include('Access-Control-Allow-Origin')
    end
  end

  context 'when request is not a valid preflight request' do
    before(:each) do
      options @allowed_path, {},
              'HTTP_ORIGIN' => @allowed_origin
    end

    it 'returns a 204 status with no content' do
      expect(response).to have_http_status(204)
    end

    # Disabled temporarily until this bug is fixed in rack-cors:
    # https://github.com/cyu/rack-cors/issues/58
    xit 'does not include CORS headers' do
      expect(headers.keys).not_to include('Access-Control-Allow-Origin')
    end
  end
end
