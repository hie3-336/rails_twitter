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
  post '/like/:tweet_id', to: 'tweets#like_tweet', as: :like_tweet
  post '/retweet/:tweet_id', to: 'tweets#retweet_tweet', as: :retweet_tweet
  post '/bookmark/:tweet_id', to: 'tweets#bookmark_tweet', as: :bookmark_tweet

  resources :users, param: :name, only: %i[show edit update]
  post '/follow/:user_id', to: 'users#follow_user', as: :follow_user

  resources :bookmarks, only: [:index]

  resources :notifications, only: [:index]

  resources :direct_messages, only: %i[index]
  get '/direct_messages/:send_user_id', to: 'direct_messages#show_chatroom', as: :show_chatroom
  post '/direct_messages/:send_user_id', to: 'direct_messages#create', as: :post_message

  resources :tasks
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'tweets#index'
end
