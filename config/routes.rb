Rails.application.routes.draw do

  devise_for :users
  # devise_for :users

  resources :posts do
    resources :comments
  end

  root "posts#index"

  get '/about' => 'pages#about'
  get 'userposts/:id', to: 'posts#userposts', as: :userposts
  # get 'users/:id' => 'users#show'
  resources :users, only: [:show, :update, :edit]
  # get '/user/:id', to: 'pages#profile'
  # get '/myprofile', to: 'pages#myprofile'
  # get '/userinfo', to: 'pages#userinfo'
  # post '/userinfo', to: 'pages#userinfo'
end
