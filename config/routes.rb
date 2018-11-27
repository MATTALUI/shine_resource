Rails.application.routes.draw do
  # custom routes for login info
  get    'login',  controller: 'application', as: 'login'
  post   'create_session', controller: 'application', as: 'create_session'
  delete 'logout', controller: 'application', as: 'logout'
  # custom routes for audits
  get    '/audits/:entity/:id', controller: 'audits', action: 'show', as: 'audits'

  resources :clients
  resources :presets
  resources :caretakers
  resources :memos, only: [:create]
  resources :notes_group do
    resources :notes
    collection do
      get "shine_report"
    end
  end

  root to: 'notes_group#index'
end
