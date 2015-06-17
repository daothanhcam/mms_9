Rails.application.routes.draw do
  devise_for :users, path_names: {sign_in: "login", sign_up: "register"}

  root                "static_pages#home"
  get    "help"    => "static_pages#help"
  get    "about"   => "static_pages#about"

  resources :users, only: :show

  namespace :admin do
    root      "static_pages#home"
    resources :users
    resources :skills
    resources :teams
    resources :positions
  end
end
