Rails.application.routes.draw do
  mount ActionCable.server => "/cable"

  # root "admin/pull_requests#index", constraints: lambda{|request|
  #   RoleConstraint.new(:admin, :trainer, :supporter).matches? request}
  root "pull_requests#index", constraints: lambda{|request|
    RoleConstraint.new(:normal, :admin, :trainer, :supporter).matches? request}
  root "omniauth_callbacks#show"

  get "/auth/:provider/callback", to: "omniauth_callbacks#create"
  get "/auth/failure", to: "omniauth_callbacks#failure"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  post "/hook", to: "github_hooks#create"

  resources :users, only: [:show, :edit, :update]
  resources :pull_requests, only: [:index, :destroy]

  namespace :admin do
    root "pull_requests#index"
    resources :pull_requests, only: [:index, :update]
    resources :users
    resources :offices
    resources :chatrooms, except: [:new, :show]
    resources :messages, only: [:new, :create]
  end

  namespace :api do
    get "/extensions/feeds/:status", to: "extensions/feeds#show",
      constraints: {status: /ready|commented|reviewing/}
    get "/extensions/accounts", to: "extensions/accounts#show"
    post "/extensions/pull_requests/:id",
      to: "extensions/pull_requests#update"
  end
end
