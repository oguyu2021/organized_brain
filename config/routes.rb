Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :users

  resources :posts do
    collection do
      get 'search'
    end
  end

  resources :conversations do
    resources :messages
  end

  get 'users/:id/message', to: 'users#message', as: :user_message

  root 'top#index'
  resources :top, only: [:index]
  
  post 'guest_admin_login', to: 'admin_guest_sessions#create'
  
  post 'guest_login', to: 'guest_sessions#create'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
