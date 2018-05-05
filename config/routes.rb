Rails.application.routes.draw do
  get 'welcome/index'
  get 'admin' => 'admin#index' 
  controller :sessions do
    get 'login' => :new
    post 'login' => :create 
    delete 'logout' => :destroy
  end
  get "sessions/create" 
  delete "sessions/destroy" 
  resources :users

  root to: "welcome#index"
end
