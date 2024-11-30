# frozen_string_literal: true

Rails.application.routes.draw do

  # letter_opener_web用
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :tweets, only: %i[index]

  resources :tasks
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "tasks#index"
end
