# frozen_string_literal: true

Rails.application.routes.draw do
  
  devise_for :users

  resources :currencies, only: [:show, :index]

  # Defines the root path route ("/")
  root to: "currencies#index"
end
