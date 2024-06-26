require 'sidekiq/web'

Rails.application.routes.draw do

    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end
  resources :posts
  resources :user_profile
  devise_for :users
  root to: 'posts#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
