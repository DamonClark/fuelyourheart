Rails.application.routes.draw do
  root "plans#index"
  post "/plans", to: "plans#create"

  namespace :admin do
    get 'training_plans', to: 'training_plans#index', as: 'training_plans'
    get 'training_plans/edit', to: 'training_plans#edit', as: 'training_plans_edit'
    patch 'training_plans/update', to: 'training_plans#update', as: 'training_plans_update'
  end

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
