require 'rails_helper' 

RSpec.describe 'Merchants API', type: :request do 
  let!(:merchants) { create_list(:merchant, 2) }
  let!(:merchant_id) {merchants.first.id }

  describe 'GET /api/v1/merchants' do 
    before { get '/api/v1/merchants' }

    it 'returns merchants' do 
      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: :true)[:data]

      expect(merchants).not_to be_empty
      expect(merchants.count).to eq(2)

      merchants.each do |merchant|
        expect(merchant[:attributes]).to have_key(:id)
        expect(merchant[:attributes][:id]).to be_an(Integer)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end 
    end 

    it 'returns status code 200' do 
      expect(response).to have_http_status(200)
    end 
  end 
end 