require 'rails_helper' 

RSpec.describe 'Merchants API', type: :request do 
  let!(:merchants) { create_list(:merchant, 2) }
  let!(:merchant_id) {merchants.first.id }
  let!(:items) { create_list(:item, 2, merchant_id: merchants.first.id) }

  describe 'GET /api/v1/merchants' do 
    before { get '/api/v1/merchants' }

    it 'returns merchants' do 
      expect(response).to be_successful

      merchants_list = JSON.parse(response.body, symbolize_names: :true)[:data]
 
      expect(merchants_list).not_to be_empty
      expect(merchants_list.count).to eq(2)

      merchants_list.each do |merchant|

        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_a(String)
  
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

        found_merchant = JSON.parse(response.body, symbolize_names: :true)
  
        expect(found_merchant).not_to be_empty
        expect(found_merchant.count).to eq(1)

        expect(found_merchant[:data]).to have_key(:id)
        expect(found_merchant[:data][:id]).to be_a(String)

        expect(found_merchant[:data][:attributes]).to have_key(:name)
        expect(found_merchant[:data][:attributes][:name]).to be_a(String)
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

  describe 'GET /api/v1/merchants/:id/items' do
    before { get "/api/v1/merchants/#{merchant_id}/items" }

    context 'when the record exists' do
      it "returns the merchant's items" do
        item_list = JSON.parse(response.body, symbolize_names: :true)

        expect(item_list[:data]).not_to be_empty
        expect(item_list[:data].count).to eq(2)
      end 

      it 'returns status code 200' do 
        expect(response).to be_successful
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

  describe 'GET /api/v1/merchants/find' do 
    before { Merchant.create!(name: 'ABC corp') }
    before { Merchant.create!(name: 'BAC Corp') }

    let(:query_param) { '?name=Corp'}

    before { get "/api/v1/merchants/find#{query_param}" }

    context 'it can match a record' do
      it 'returns a merchant' do
        expect(response).to be_successful

        found_merchant = JSON.parse(response.body, symbolize_names: :true)

        expect(found_merchant).not_to be_empty
        expect(found_merchant.count).to eq(1)

        expect(found_merchant[:data]).to have_key(:id)
        expect(found_merchant[:data][:id]).to be_a(String)

        expect(found_merchant[:data][:attributes]).to have_key(:name)
        expect(found_merchant[:data][:attributes][:name]).to be_a(String)
        expect(found_merchant[:data][:attributes][:name]).to eq('ABC corp')
      end 
    end 
  end 
end