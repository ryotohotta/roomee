Rails.application.routes.draw do
  get 'top/index'

  root 'top#index'
  devise_for :users, controllers: {registrations: 'users/registrations', sessions: 'users/sessions', omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :articles do
    resources :talks, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  get "tweet/input"
  post "tweet/update"
  resources :users, only: [:show]
end