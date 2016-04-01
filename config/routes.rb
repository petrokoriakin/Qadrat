Rails.application.routes.draw do

  devise_for :users

  resources :posts do
    resources :comments
  end

  root "posts#index"

  get '/about' => 'pages#about'
  get '/alltags' => 'pages#alltags'
  get 'userposts/:id', to: 'posts#userposts', as: :userposts
  get 'tags/:tag', to: 'posts#index', as: :tag
  resources :users, only: [:show, :update, :edit]
end
