Rails.application.routes.draw do
  root to: 'clients#index'

  get    'login',  controller: 'application', as: 'login'
  post   'create_session', controller: 'application', as: 'create_session'
  delete 'logout', controller: 'application', as: 'logout'


  resources :clients

  # get 'clients/index'
  #
  # get 'clients/show'
  #
  # get 'clients/new'
  #
  # get 'clients/create'
  #
  # get 'clients/edit'
  #
  # get 'clients/update'
  #
  # get 'clients/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
