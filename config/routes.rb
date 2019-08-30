Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

    get 'admins/login' => 'admins#login'
    get 'admins/logout' => 'admins#logout'
    post 'admins/login' => 'admins#check'

    get 'admins/manager' => 'admins#manager'
    get '/admins/manager/search_sciper' => 'admins#search_sciper'
    get '/admins/manager/add_user' => 'admins#add_user'
    post 'admins/manager' => 'admins#create_user'
    get 'admins/edit_user/:user_id' => 'admins#edit_user'
    #delete 'admins/manager' => 'admins#delete_user'
    delete 'admins/delete_user/:user_id' => 'admins#delete_user'
    post 'admins/save_user/:user_id' => 'admins#save_user'
    post 'admins/save_new_user/:old_sciper' => 'admins#save_new_user'
    post 'admins/add_to_balance/:user_id' => 'admins#add_to_balance'
    get '/admins/manager/write_mail' => 'admins#write_mail'
    post '/admins/manager/send_mail' => 'admins#send_mail'
    delete '/admins/manager/delete_picture/:user_id' => 'admins#delete_picture'

    root 'index#show'

    get 'buy/show/:id' => 'buy#show'
    get 'buy/edit/:id' => 'buy#edit_picture'
    post 'buy/save_picture' => 'buy#save_picture'
    post 'buy/new_order/:id' => 'buy#new'
    post 'buy/:user_id/add/:product_id' => 'buy#add'
    post 'buy/pay/:id/:cost' => 'buy#pay'
end
