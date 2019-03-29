Rails.application.routes.draw do
  get 'placements_imports/new'
  get 'placements_imports/create'
  
  delete 'admins/:id' => 'admins#destroy', :as => :admin_destroy_user
  get 'admins' => 'admins#show'
  
  devise_for :users, :controllers => {:registrations => "users/registrations"} 
  
  #resources :users
  #devise_scope :user do
   # get 'login', to: 'devise/sessions#new'
  #end
  resources :placements, :comments, :licensees
  resources :placements_imports, only: [:new, :create]
  resource :cart, only: [:show]
  resources :cart_placements
  root to: 'placements#index'
  resources :admins, only: [:show, :edit, :update, :destroy]
end