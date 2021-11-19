Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users,
            path: '',
            path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'},
            controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  resources :users, only: [:show]
end
