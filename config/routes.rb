Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :omniauth_callbacks => 'users/omniauth_callbacks',
    :registrations => 'users/registrations'
  }

  devise_scope :user do
    get 'users/new_address_preset', to: 'users/registrations#new_address_preset'
    post 'users/create_address_preset', to: 'users/registrations#create_address_preset'
  end

  resources :users, only: [:show]

  root to: 'items#index'
  resources :tags, only: [:index]
  resources :items do
    resources :orders, only: [:index, :create]
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    
    collection do
      get 'search'
    end

    member do
      get :purchase_confirm
      post :purchase
    end
  end
  # resources :comments, only: [:destroy]
  resources :cards, only: [:index, :new, :create, :destroy]
  
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show, :index]
  resources :memberships, only: [:new, :create]
end
