Rails.application.routes.draw do
  devise_for :users
  root to: 'welcome#index'
  resources :charges, only: [:new, :create]
  resources :users do
    put :downgrade
  end
  resources :wikis do
    collection do
      get '/user_wikis', to: 'wikis#user_wikis', as: :user
    end
  end
  get 'welcome/index'
  get 'welcome/about'

  end
