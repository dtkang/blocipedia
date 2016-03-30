Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  resources :wikis
  
  resources :charges, only: [:new, :create, :edit, :update]
  
  get 'welcome/index'
  root to: 'welcome#index'

end
