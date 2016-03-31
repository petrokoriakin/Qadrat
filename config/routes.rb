Rails.application.routes.draw do

  devise_for :users

  resources :posts do
    resources :comments
  end

  root "posts#index"

  get '/about' => 'pages#about'
  get 'userposts/:id', to: 'posts#userposts', as: :userposts
  resources :users, only: [:show, :update, :edit]
end
