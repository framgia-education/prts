Rails.application.routes.draw do
  mount ActionCable.server => "/cable"
  root "admin/pull_requests#index", constraints: lambda {|request| RoleConstraint.new(:admin, :trainer).matches?(request)}
  root "pull_requests#index", constraints: lambda {|request| RoleConstraint.new(:normal).matches?(request)}
  root "omniauth_callbacks#show"
  get "/auth/:provider/callback", to: "omniauth_callbacks#create"
  get "/auth/failure", to: "omniauth_callbacks#failure"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  post "/hook", to: "github_hooks#create"

  resources :users
  resources :pull_requests, only: [:index, :destroy]

  namespace :admin do
    root "pull_requests#index"
    resources :pull_requests
    resources :users
  end

  namespace :api do
    get "/extensions/feeds/:status", to: "extensions/feeds#show",
      constraints: {status: /ready|commented|reviewing/}
    get "/extensions/accounts", to: "extensions/accounts#show"
    post "/extensions/pull_requests/:id",
      to: "extensions/pull_requests#update"
  end
end
