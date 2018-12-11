Rails.application.routes.draw do

  # custom routes for about page
  get    'about',  controller: 'application', as: 'about'
  # custom routes for login info
  get    'login',  controller: 'application', as: 'login'
  post   'create_session', controller: 'application', as: 'create_session'
  delete 'logout', controller: 'application', as: 'logout'
  # custom routes for audits
  get    '/audits/:entity/:id', controller: 'audits', action: 'show', as: 'audits'

  resources :clients
  resources :presets
  resources :memos, only: [:create]
  resources :organizations, only: [:show, :edit, :update]
  resources :notes_group do
    resources :notes
    collection do
      get "shine_report"
    end
  end
  resources :caretakers do
    collection do
      get "password"
      post "password", action: :update_password
    end
  end

  root to: 'notes_group#index'
end
