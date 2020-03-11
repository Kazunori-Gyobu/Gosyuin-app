Rails.application.routes.draw do
  root 'home#index'
  devise_for :users,
    path: '',
    path_names: {
      sign_up: '',
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      registraions: 'users/registrations',
      sessions: 'users/sessions'
    }
end
