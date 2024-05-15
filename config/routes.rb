Rails.application.routes.draw do
  root 'home#index'
  resources :registrations
  resources :sessions, only: [:new, :create]
  resources :users, only: [:show, :edit, :update]
  resources :books do
    patch :create_borrow, on: :member
    patch :close_borrow, on: :member
  end
  delete 'logout' => 'sessions#destroy', as: :logout
  match '*unmatched', to: 'application#not_found_method', via: :all
  get "up" => "rails/health#show", as: :rails_health_check
end
