Rails.application.routes.draw do
  devise_for :users, path_names: {sign_in: "login", sign_up: "register"}

  root                "static_pages#home"
  get    "help"    => "static_pages#help"
  get    "about"   => "static_pages#about"

  resources :users, only: :show
  resources :users do
    resource :positions
    resource :skill_users
    get "skills" => "skill_users#show"
  end

  namespace :admin do
    root      "static_pages#home"
    resources :users
    resources :skills
    resources :positions
    resources :activity_logs, only: [:index, :destroy]
    resources :projects do
      resource :project_users
      get "members" => "project_users#show"
    end
    resources :teams do
      resource :team_users
      get "members" => "team_users#show"
    end
  end
end
