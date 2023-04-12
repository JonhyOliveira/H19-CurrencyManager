# frozen_string_literal: true

Rails.application.routes.draw do
  
  devise_for :users

  resources :currencies, only: [:show, :index] do
    put "follow", to: "currencies#follow"
    put "unfollow", to: "currencies#unfollow"
  end

  # Defines the root path route ("/")
  root to: "currencies#index"
end
