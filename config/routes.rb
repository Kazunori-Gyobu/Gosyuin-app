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
  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create, :destroy]
end
