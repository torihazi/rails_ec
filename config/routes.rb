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

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
