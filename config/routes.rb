Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: "items#index"

  get '/merchants', to: 'merchants#index'
  get '/merchants/new', to: 'merchants#new'
  get '/merchants/:id', to: 'merchants#show'
  post '/merchants', to: 'merchants#create'
  get '/merchants/:id/edit', to: 'merchants#edit'
  patch '/merchants/:id', to: 'merchants#update'
  delete '/merchants/:id', to: 'merchants#destroy'

  get '/items', to: 'items#index'
  get '/merchants/:merchant_id/items', to: 'items#index'
  get '/items/:id', to: 'items#show'
  get '/merchants/:merchant_id/items/new', to: 'items#new'
  post '/merchants/:merchant_id/items', to: 'items#create'
  get '/items/:id/edit', to: 'items#edit'
  patch '/items/:id', to: 'items#update'
  delete '/items/:id', to: 'items#destroy'

  resources :carts, only: [:create]
  post '/cart', to: 'carts#add_one'
  patch '/cart', to: 'carts#remove_one'
  get '/cart', to: 'carts#index'
  delete '/cart', to: 'carts#destroy'
  delete '/cart/:item_id', to: 'carts#remove_item'

  get '/verified_order', to: 'verified_order#show'
  get '/verified_order/:verified_order_id/edit', to: 'verified_order#edit'
  patch '/verified_order/:verified_order_id', to: 'verified_order#update'
  delete '/verified_order/:verified_order_id', to: 'verified_order#destroy'

  get '/order/new', to: 'order#new'
  post '/order', to: 'order#create'
  get '/order/:order_id', to: 'order#show'

  get '/items/:item_id/reviews/new', to: 'reviews#new'
  get '/items/:item_id/reviews/:review_id/edit', to: 'reviews#edit'
  post '/items/:item_id', to: 'reviews#create'
  patch '/items/:item_id/reviews/:review_id', to: 'reviews#update'
  delete '/items/:item_id/reviews/:review_id', to: 'reviews#destroy'
end
