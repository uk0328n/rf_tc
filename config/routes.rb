Rails.application.routes.draw do

  get 'top/index'

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }

  resources :activities
  resources :events
  resources :customers

  root 'top#index'
end
