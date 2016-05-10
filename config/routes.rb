Rails.application.routes.draw do
  root 'articles#index'
  devise_for :users
  resources :articles do
    resources :talks, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  resources :users, only: [:show] do
    get :likes, on: :member
  end
end