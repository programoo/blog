Rails.application.routes.draw do
  resources :replies
  resources :feeds
  resources :user_likes
  resources :movie_metrics
  namespace :admin do
    get "dashboard/index"
    resources :movies
  end
  devise_for :users
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



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  root "pages#home"
end
