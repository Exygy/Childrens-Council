require 'rails_helper'

describe 'GET /providers/:id' do
  context 'with valid id' do
    before :all do
      @provider = FactoryGirl.create(:provider)
    end

    before :each do
      get api_provider_url(@provider)
    end

    after(:all) do
      Provider.find_each(&:destroy)
    end

    it 'includes the organization id' do
      expect(json['id']).to eq(@provider.id)
    end

    it 'includes the name attribute' do
      expect(json['name']).to eq(@provider.name)
    end

    it 'is json' do
      expect(response.content_type).to eq('application/json')
    end

    it 'returns a successful status code' do
      expect(response).to have_http_status(200)
    end

    it 'includes the full representation' do
      expect(json.keys).to eq %w[id name alternate_name contact_name phone
                                 phone_ext phone_other phone_other_ext fax
                                 email url address_1 address_2 city_id
                                 state_id cross_street_1 cross_street_2
                                 mail_address_1 mail_address_2 mail_city_id
                                 mail_state_id ssn tax_id created_at updated_at
                                 latitude longitude schedule_year_id
                                 zip_code_id care_type_id description
                                 licensed_ages neighborhood_id mail_zip_code]
    end
  end

  context 'with invalid id' do
    before :each do
      get api_provider_url(999)
    end

    it 'returns a status key equal to 404' do
      expect(json['status']).to eq(404)
    end

    it 'returns a helpful message' do
      expect(json['message'])
        .to eq('The requested resource could not be found')
    end

    it 'returns a 404 status code' do
      expect(response).to have_http_status(404)
    end

    it 'is json' do
      expect(response.content_type).to eq('application/json')
    end
  end
end
