Rails.application.routes.draw do
  root 'articles#index'
  devise_for :users
  resources :articles do
    resources :talks, only: [:create]
  end
  get 'users/:id' => 'users#show'
end