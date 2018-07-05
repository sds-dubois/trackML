Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#home"

  post "/api/create_model", to: "models#api_create"
  post "/api/create_project", to: "projects#api_create"
  post "/api/create_project", to: "projects#api_create"
  post "/api/create_experiment", to: "experiments#api_create"

  resources :projects
  resources :models
  resources :experiments
end
