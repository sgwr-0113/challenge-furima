Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items do
    resources :orders, only: [:index, :create]
    resources :comments, only: :create
    member do
      get :purchase_confirm
      post :purchase
    end
  end
  resources :cards, only: [:index, :new, :create, :destroy]
end
