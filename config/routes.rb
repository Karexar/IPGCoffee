Rails.application.routes.draw do
  resources :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'index#show'
  get 'buy/show/:id' => 'buy#show'
  post 'buy/new_order/:id' => 'buy#new'
  post 'buy/:user_id/add/:product_id' => 'buy#add'
  post 'buy/pay/:id/:cost' => 'buy#pay'
end
