Rails.application.routes.draw do
  get 'licensees_imports/new'
  get 'licensees_imports/create'
  get 'placements_imports/new'
  get 'placements_imports/create'
  
  delete 'admins/:id', to: 'admins#destroy', as: :admin_destroy_user
  get 'admins' => 'admins#index'
  
  devise_for :users, :controllers => {:registrations => "users/registrations"} 
  
  # resources :users
  # devise_scope :user do
  #   get 'login', to: 'devise/sessions#new'
  # end
  resources :placements, :comments, :licensees
  resources :placements_imports, only: [:new, :create]
  resources :licensees_imports, only: [:new, :create]
  root to: 'placements#index'

  resources :carts do
    member do
      get 'start'
      delete 'remove'
      put 'submit'
    end
    collection do
      post 'add'
    end
  end
  root to: 'placements#index'
  resources :admins, only: [:index, :edit, :update, :destroy]
end

