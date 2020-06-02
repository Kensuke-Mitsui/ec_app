Rails.application.routes.draw do


  root to: "items#index"
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/sign_up', to: 'users/registrations#create'
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end


  resources :items, only: [:index]
end
