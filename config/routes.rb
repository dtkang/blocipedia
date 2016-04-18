Rails.application.routes.draw do
  devise_for :users
  
  resources :users, only: [:show] do
    resources :collaborators, only: [:new, :create, :delete, :destroy]
  end
  
  resources :wikis do
    resources :collaborators, only: [:new, :create, :delete, :destroy]
    collection do
      post :bulk_collaborators_update
    end
  end
  
  resources :charges, only: [:new, :create, :edit, :update]
  
  get 'welcome/index'
  root to: 'welcome#index'

end
