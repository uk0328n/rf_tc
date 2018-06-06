Rails.application.routes.draw do

  resources :event_details
  resources :advisors
  get 'top/index'
  get 'pages/index'

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_scope :admin do
    get 'admins', to: 'admins#index'
    get 'admins/new', to: 'admins#new', as: 'new_admin'
    post 'admins', to: 'admins#create'
    get 'admins/:id', to: 'admins#show', as: 'admin'
    get 'admins/edit/:id', to: 'admins#edit', as: 'edit_admin'
    patch 'admins/:id', to: 'admins#update'
    delete 'admins/:id', to: 'admins#destroy'
  end

  resources :activities
  resources :events
  resources :customers

  root 'top#index'
end
