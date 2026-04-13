Rails.application.routes.draw do
  resource :session, only: %i[new create destroy]
  resources :users, only: %i[new create]

  resources :athletes do
    member do
      get :stats
    end
    resources :training_sessions, only: %i[new create]
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "home#show"
end
