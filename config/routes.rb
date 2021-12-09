Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
      get '/merchants/:id/items', to: 'merchants/items#index'
      resources :merchants, only: [:index, :show]
      get '/items/:id/merchant', to: 'items/merchants#show'
      resources :items
    end 
  end 
end