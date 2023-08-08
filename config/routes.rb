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

  root 'posts#index'
  # 以下を追加
  post '/posts/guest_sign_in', to: 'posts#guest_sign_in'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
