Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
      get '/revenue', to: 'merchants/revenue#total'
      get '/revenue/merchants', to: 'merchants/revenue#index'
      get '/merchants/most_items', to: 'merchants/items_sold#index'
      get '/merchants/find', to: 'merchants/search#show'
      get '/merchants/:id/items', to: 'merchants/items#index'
      resources :merchants, only: [:index, :show]
      get '/items/:id/merchant', to: 'items/merchants#show'
      get '/items/find_all', to: 'items/search#index'
      resources :items
    end 
  end 
end