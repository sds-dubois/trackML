Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#home"

  post "/api/create_model", to: "models#api_create"
  post "/api/create_project", to: "projects#api_create"
  post "/api/create_project", to: "projects#api_create"
  post "/api/create_experiment", to: "experiments#api_create"
  post "/api/create_experiments", to: "experiments#api_bulk_create"
  
  get "/models/:id/export", to: "models#export", as: :export_model
  get "/models/:id/inspect", to: "models#inspect", as: :inspect_model
  get "/models/:id/parameter_graph", to: "models#parameter_graph", as: :parameter_graph

  get "/projects/:id/export", to: "projects#export", as: :export_project

  resources :projects
  resources :models
  resources :experiments
end
