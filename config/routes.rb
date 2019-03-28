Rails.application.routes.draw do
  get 'placements_imports/new'
  get 'placements_imports/create'
  devise_for :users
  resources :placements, :comments, :licensees
  resources :placements_imports, only: [:new, :create]
  root to: 'placements#index'
end
