# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users

  get "currencies/followed", to: "currencies#followed", as: "followed_currencies"
  get "currencies/all", to: "currencies#all", as: "all_currencies"

  resources :currencies, only: [:show, :index] do

    # alias to follow a currency
    put "follow", to: "currencies#follow"
    post "follow", to: "currencies#follow"

    # alias to unfollow
    delete "follow", to: "currencies#unfollow"
  end

  # Defines the root path route ("/")
  root to: "currencies#index"
end
