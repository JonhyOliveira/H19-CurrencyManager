# frozen_string_literal: true

Rails.application.routes.draw do
  scope path: "user" do
    get "settings/show", to: "user_settings#show"
    get "settings/edit", to: "user_settings#edit"
    put "settings/update", to: "user_settings#update"
  end

  resources :currencies, only: [:show, :index] do
    # post "following", to: ""
  end

  devise_for :users

  # Defines the root path route ("/")
  root to: "home#index"
end
