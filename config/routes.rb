# frozen_string_literal: true

Rails.application.routes.draw do
  # letter_opener_web用
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions'
  }

  resources :tweets, only: %i[index create show]
  post '/tweets/:id', to: 'tweets#post_comment'
  post '/like/:tweet_id', to: 'tweets#like_tweet' , as: :like_tweet

  resources :users, param: :name, only: %i[show edit update]

  resources :tasks
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'tweets#index'
end
