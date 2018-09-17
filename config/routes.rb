Rails.application.routes.draw do

  root to: 'clients#index'

  get    'login',  controller: 'application', as: 'login'
  post   'create_session', controller: 'application', as: 'create_session'
  delete 'logout', controller: 'application', as: 'logout'


  resources :clients
  resources :notes
  resources :memos, only: [:create]
end
