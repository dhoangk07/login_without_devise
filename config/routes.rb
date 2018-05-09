Rails.application.routes.draw do
  get 'welcome/index'
  get 'admin' => 'admin#index' 

  controller :sessions do
    get 'login' => :new 
    post 'login' => :create 
    delete 'logout' => :destroy
  end

  get "sessions/create" 

  get "users/forgot_password", to: "users#forgot_password", :as => :user_forgot_password
  
  post "users/forgot_password", to: "users#handle_forgot_password"

  get "users/reset_password", to: "users#reset_password"
  
  post "users/reset_password", to: "users#handle_reset_password"


  delete "sessions/destroy" 

  resources :users 

  get '/users/:token/unlock', to: 'users#unlock', :as => :unlock_user
  
  root to: "welcome#index"
end
