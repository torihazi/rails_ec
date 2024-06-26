# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :products
  end
  root 'products#index'
  resources :products, only: %i[index show]
  resources :cart_products, only: %i[create destroy]
  resources :carts, only: %i[index]
  resources :orders, only: %i[index show create]
  resources :promotion_codes, only: %i[create destroy]

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
