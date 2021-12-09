require 'rails_helper' 

RSpec.describe 'Items API', type: :request do 
  let!(:merchant) { create(:merchant) }
  let!(:items) { create_list(:item, 2, merchant_id: merchant.id) }
  let!(:item_id) { items.first.id }

  describe 'GET /api/v1/items' do 
    before { get '/api/v1/items' }

    it 'returns items' do 
      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: :true)[:data]

      expect(items).not_to be_empty
      expect(items.count).to eq(2)

      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_an(Integer)
      end 
    end 

    it 'returns status code 200' do 
      expect(response).to have_http_status(200)
    end 
  end 

  describe 'GET /api/v1/items/:id' do 
    before { get "/api/v1/items/#{item_id}" }

    context 'when the record exists' do
      it 'returns the item' do
        expect(response).to be_successful

        item = JSON.parse(response.body, symbolize_names: :true)

        expect(item).not_to be_empty
        expect(item.count).to eq(1)
        
        expect(item[:data]).to have_key(:id)
        expect(item[:data][:id]).to be_a(String)

        expect(item[:data][:attributes]).to have_key(:name)
        expect(item[:data][:attributes][:name]).to be_a(String)

        expect(item[:data][:attributes]).to have_key(:description)
        expect(item[:data][:attributes][:description]).to be_a(String)

        expect(item[:data][:attributes]).to have_key(:unit_price)
        expect(item[:data][:attributes][:unit_price]).to be_a(Float)

        expect(item[:data][:attributes]).to have_key(:merchant_id)
        expect(item[:data][:attributes][:merchant_id]).to be_an(Integer)
      end 

      it 'returns status code 200' do 
        expect(response).to have_http_status(200)
      end 
    end 

    context 'when the record does not exist' do 
      let(:item_id) { 1000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end 

      it 'returns a not found message' do 
        expect(response.body).to match(/Couldn't find Item/)
      end 
    end 
  end 

  describe 'POST /api/v1/items' do 
    let(:valid_attributes) { { name: 'Wooden Chair', description: 'A chair made of wood', unit_price: 77.89, merchant_id: merchant.id } }

    context 'when the request is valid' do 
      before { post '/api/v1/items', params: valid_attributes }

      it 'creates an item' do
        created_item = Item.last

        expect(created_item.name).to eq(valid_attributes[:name])
        expect(created_item.description).to eq(valid_attributes[:description])
        expect(created_item.unit_price).to eq(valid_attributes[:unit_price])
        expect(created_item.merchant_id).to eq(valid_attributes[:merchant_id])
      end

      it 'returns status code 201' do
        expect(response).to be_successful
        expect(response).to have_http_status(201)
      end 
    end 

    context 'when the request is invalid' do 
      before { post '/api/v1/items', params: { name: 'wooden chair', unit_price: 77.89, merchant_id: merchant.id} }

      it 'returns status code 422' do 
        expect(response).to have_http_status(422)
      end 

      it 'returns a validation failure message' do 
        expect(response.body).to match(/Validation failed: Description can't be blank/)
      end 
    end 

    context 'when the user sends unused params' do
      before { post '/api/v1/items', params: { name: 'wooden chair', description: 'Steel ice creams',unit_price: 77.89, merchant_id: merchant.id, unused_param: 'Hello' } }

      it 'ignores unused param and is successful' do 
        expect(response).to be_successful
        expect(response).to have_http_status(201)
      end 
    end 
  end 

  describe 'PUT /api/v1/item' do 
    let(:valid_attributes) { { name: 'New Item' } }

    context 'when the record exists' do 
      before { put "/api/v1/items/#{item_id}", params: valid_attributes }

      it 'updates the record' do
        item = Item.find_by(id: item_id)
        
        expect(item.name).to eq(valid_attributes[:name])
      end 

      it 'returns status code 200' do 
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end 
    end 

    # context 'when the record does not exist' do 
    #   let(:item_id) { 1000 }

    #   it 'returns status code 404' do
    #     expect(response).to have_http_status(404)
    #   end 

    #   it 'returns a not found message' do 
    #     expect(response.body).to match(/Couldn't find Item/)
    #   end 
    # end 
  end 

  describe 'DELETE /api/v1/item/:id' do 
    before { delete "/api/v1/items/#{item_id}"}

    context 'when the item exists' do 
      it 'returns status code 204' do
        expect(response).to be_successful
        expect(response).to have_http_status(204)
      end 

      it 'can destroy a book' do 
        expect(Item.count).to eq(1)
      end 
    end 

    context 'when the item does not exist' do 
      let(:item_id) { 1000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end 

      it 'returns a not found message' do 
        expect(response.body).to match(/Couldn't find Item/)
      end 
    end 
  end 

  describe 'GET /api/v1/items/:id/merchant' do 
    before { get "/api/v1/items/#{item_id}/merchant"}

    context 'when the item exists' do
      it 'returns the merchant' do 
        found_merchant = JSON.parse(response.body, symbolize_names: :true)

        expect(found_merchant[:data]).not_to be_empty
        expect(found_merchant.count).to eq(1)
      end 

      it 'returns status code 200' do 
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end 
    end 

    context 'when the record does not exist' do 
      let(:item_id) { 1000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end 

      it 'returns a not found message' do 
        expect(response.body).to match(/Couldn't find Item/)
      end 
    end 
  end 
end