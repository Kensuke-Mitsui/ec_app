Rails.application.routes.draw do


  root to: "products#index"

  #deviseのルーティング
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/sign_up', to: 'users/registrations#create'
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
    get 'creditcards', to: 'users/registrations#new_credit_card'
    post 'creditcards', to: 'users/registrations#pay'
  end

  #クレジットカードのルーティング

  # resources :credit_card, only: [:new, :show] do
  #   collection do
  #     post 'show', to: 'credit_card#show'
  #     post 'pay', to: 'credit_card#pay'
  #     post 'delete', to: 'credit_card#delete'
  #   end
  # end

  #productのルーティング
  resources :products, only: [:new, :create, :show] do
    resources :orders, only: [:index] do
      collection do
        post 'pay', to: 'orders#pay'
        get 'done', to: 'orders#done'
      end
    end
  end


  #order(注文)のルーティング
end
