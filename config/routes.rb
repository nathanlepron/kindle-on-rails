Rails.application.routes.draw do
  root 'home#index'
  resources :registrations
  resources :sessions, only: [:new, :create]
  resources :users, only: [:show, :edit, :update]
  resources :books, only: [:index, :new, :show, :update]
  resources :borrows, only: [] do
    member do
      post :create_borrow
      delete :close_borrow
    end
  end
  delete 'logout' => 'sessions#destroy', as: :logout
  match '*unmatched', to: 'application#not_found_method', via: :all
  get "up" => "rails/health#show", as: :rails_health_check
end
