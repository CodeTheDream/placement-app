Rails.application.routes.draw do
  devise_for :users
  resources :placements, :comments, :licensees
  get '/' => 'placements#index'
end

