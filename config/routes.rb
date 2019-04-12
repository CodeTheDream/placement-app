Rails.application.routes.draw do

  root to: 'placements#index'
  delete 'admins/:id', to: 'admins#destroy', as: :admin_destroy_user
  get 'admins' => 'admins#index'
  
  devise_for :users, :controllers => {:registrations => "users/registrations"} 
  
  
  resources :comments, :licensees
  resources :placements 
  
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
  
  resources :admins, only: [:index, :edit, :update, :destroy]
  resources :profile, only: [:edit, :update]
end
