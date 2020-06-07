Rails.application.routes.draw do


  root to: "items#index"
  #deviseのルーティング
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/sign_up', to: 'users/registrations#create'
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  #クレジットカードのルーティング
  resources :credit_card, only: [:new, :show] do
    collection do
      post 'show', to: 'credit_card#show'
      post 'pay', to: 'credit_card#pay'
      post 'delete', to: 'credit_card#delete'
    end
  end
  resources :items, only: [:index]
end
