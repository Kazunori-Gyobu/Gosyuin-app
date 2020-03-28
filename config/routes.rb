Rails.application.routes.draw do
  root 'home#index'
  devise_for :users,
    path: '',
    path_names: {
      sign_up: '',
      sign_in: 'login',
      sign_out: 'logout',
      registration: "signup",
    },
    controllers: {
      registrations: "users/registrations",
      sessions: "users/sessions",
      confirmations: "users/confirmations"
    }
  resources :users, only: [:index, :show] do
    member do
      get :following, :followers
    end
  end
  resources :stamps
  resources :posts, only: [:index, :new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :stampbooks, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :likes, only: [:create, :destroy]
end
