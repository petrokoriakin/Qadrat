Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'subscriptions/follow_tag'

  get 'subscriptions/unfollow_tag'

  devise_for :users

  resources :posts do
    resources :comments
  end

  root "posts#index"

  get '/about' => 'pages#about'
  get 'userposts/:id', to: 'posts#userposts', as: :userposts
  get 'tags/:tag', to: 'posts#withtag', as: :tag
  resources :users, only: [:show, :update, :edit]

  post '/follow_tag/:tag', to: 'subscriptions#follow_tag', as: :follow_tag
  post 'unfollow_tag/:tag', to: 'subscriptions#unfollow_tag', as: :unfollow_tag

  get '/myfeed', to: 'posts#usernews', as: :myfeed
end
