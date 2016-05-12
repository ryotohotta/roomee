Rails.application.routes.draw do
  get 'top/index'

  root 'articles#index'
  devise_for :users
  resources :articles do
    resources :talks, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  resources :users, only: [:show]

end