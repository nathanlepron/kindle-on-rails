Rails.application.routes.draw do
  resources :books
  root 'home#index'
  resources :registrations
  resources :sessions, only: [:new, :create]
  match '*unmatched', to: 'application#not_found_method', via: :all
  get "up" => "rails/health#show", as: :rails_health_check
end
