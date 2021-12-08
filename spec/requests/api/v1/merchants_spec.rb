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

  describe 'GET /api/v1/merchants/:id' do 
    before { get "/api/v1/merchants/#{merchant_id}" }

    context 'when the record exists' do
      it 'returns the merchant' do
        expect(response).to be_successful

        merchant = JSON.parse(response.body, symbolize_names: :true)
  
        expect(merchant).not_to be_empty
        expect(merchant.count).to eq(1)

        expect(merchant[:data][:attributes]).to have_key(:id)
        expect(merchant[:data][:attributes][:id]).to be_an(Integer)

        expect(merchant[:data][:attributes]).to have_key(:name)
        expect(merchant[:data][:attributes][:name]).to be_a(String)
      end 

      it 'returns status code 200' do 
        expect(response).to have_http_status(200)
      end 
    end 

    context 'when the record does not exist' do 
      let(:merchant_id) { 1000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end 

      it 'returns a not found message' do 
        expect(response.body).to match(/Couldn't find Merchant/)
      end 
    end 
  end 
end