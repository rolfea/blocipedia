Rails.application.routes.draw do
  devise_for :users
  root to: 'welcome#index'
  resources :users
  resources :wikis
  get 'welcome/index'
  get 'welcome/index'
  get 'welcome/about'

  end
