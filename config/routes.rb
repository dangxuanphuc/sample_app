Rails.application.routes.draw do
  root to: "static_pages#home"
  get "password_resets/new"
  get "password_resets/edit"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users do
    member do
      resources :followings, :followers, only: %i(index)
    end
  end
  resources :account_activations, only: %i(edit)
  resources :password_resets, only: %i(new create edit update)
  resources :microposts, only: %i(create destroy)
  resources :relationships, only: %i(create destroy)
end
