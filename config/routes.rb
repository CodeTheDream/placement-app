Rails.application.routes.draw do
  get 'licensees_imports/new'
  get 'licensees_imports/create'
  get 'placements_imports/new'
  get 'placements_imports/create'
  devise_for :users
  resources :placements, :comments, :licensees
  resources :placements_imports, only: [:new, :create]
  resources :licensees_imports, only: [:new, :create]
  root to: 'placements#index'
end



