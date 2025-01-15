Rails.application.routes.draw do
  # resource :session
  # resources param: :token

  resources :passwords
  resources :movies, only: [ :index, :show ] do
    resources :reviews, only: [ :create, :destroy ]
  end

  # User Profiles
  scope "user/:user_id" do
    resource :profile, only: [ :show, :edit, :update ]
  end

  # Sessions
  get "login", to: "sessions#new", as: "new_session"
  post "login", to: "sessions#create"

  # Registrations
  get "sign-up", to: "registrations#new"
  post "sign-up", to: "registrations#create"

  # Logout
  delete "logout", to: "sessions#destroy"

  # Redirects
  get "sessions/new", to: redirect("/login")

  # Search
  get "search", to: "search#index"

  # TMDB (For importing movies)
  get "tmdb/:id", to: "tmdb#show", as: :tmdb_movie

  # Home
  root "home#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

    # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
    # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
    # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

    # Defines the root path route ("/")
    # root "posts#index"
end
