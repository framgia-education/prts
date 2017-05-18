Rails.application.routes.draw do
  root "pull_requests#index"
  get "/auth/:provider/callback", to: "omniauth_callbacks#create"
  get "/auth/failure", to: "omniauth_callbacks#failure"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users
  resources :pull_requests

  namespace :admin do
    root "pull_requests#index"
    resources :pull_requests
    resources :users
  end
end
