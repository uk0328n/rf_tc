Rails.application.routes.draw do

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

  get 'customers', to: 'people#customers_index', as: 'customers'
  get 'customers/new', to: 'people#customer_new', as: 'new_customer'
  post 'customers', to: 'people#customer_create'
  get 'customers/:id', to: 'people#customer_show', as: 'customer'
  get 'customers/edit/:id', to: 'people#customer_edit', as: 'edit_customer'
  patch 'customers/:id', to: 'people#customer_update'
  delete 'customers/:id', to: 'people#customer_destroy'
  post 'customers/import', to: 'people#customers_import', as: 'import_customers'
  get 'advisors', to: 'people#advisors_index', as: 'advisors'
  get 'advisors/new', to: 'people#advisor_new', as: 'new_advisor'
  post 'advisors', to: 'people#advisor_create'
  get 'advisors/:id', to: 'people#advisor_show', as: 'advisor'
  get 'advisors/edit/:id', to: 'people#advisor_edit', as: 'edit_advisor'
  patch 'advisors/:id', to: 'people#advisor_update'
  delete 'advisors/:id', to: 'people#advisor_destroy'
  post 'advisors/import', to: 'people#advisors_import', as: 'import_advisors'

  resources :events
  scope :events do
    get '/:id/fix', to: 'events#fix', as: 'fix_event'
  end

  resources :activities
  resources :event_details

  root 'top#index'
end
