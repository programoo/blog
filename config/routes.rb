Rails.application.routes.draw do
  resources :chapters
  get "notifications/index"
  resources :replies
  resources :feeds
  resources :user_likes
  resources :movie_metrics
  namespace :admin do
    get "dashboard/index"
    resources :movies do
      collection do
        post :fetch
      end
    end
  end
  resources :comments do
    resources :replies
  end
  resources :movies
  get "pages/home"
  resources :posts
  resources :movies do
    resources :comments, only: [:create, :destroy, :index]
  end

  namespace :admin do
    get "dashboard", to: "dashboard#index"
    resources :movies
  end
  #user authen, sign up feature
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations"
  }

  #user profile feature
  resources :users, only: [:index, :show, :edit, :update]

  resources :movies, only: [:show, :index] do
    resource :rating, only: [:create], controller: 'ratings'
  end
  # config/routes.rb
  resources :movies do
    resource :rating, only: [:create], controller: "ratings"
  end

  resources :notifications

  get "up" => "rails/health#show", as: :rails_health_check

  root "pages#home"
end
