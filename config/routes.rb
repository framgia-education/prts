Rails.application.routes.draw do
  root "static_pages#home"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :pull_requests
  namespace :admin do
    root "pull_requests#index"
    resources :pull_requests
  end
end
