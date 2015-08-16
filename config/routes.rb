# require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index]

  resources :issues, only: [:index, :new, :create, :show] do
    member do
      patch 'change_status', to: 'issues#change_status'
      resources :comments, only: [:create]
    end
  end

  # authenticated :user do
  #   mount Sidekiq::Web => '/sidekiq'
  # end

  root 'issues#index'
end
