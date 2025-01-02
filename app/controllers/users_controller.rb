# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find_by(name: params[:name])
    @user_tweets = Tweet.where(user_id: @user.id).with_attached_image.page(params[:page]).per(5)

    @like_tweets = Tweet.where(id: @user.likes.map(&:tweet_id)).with_attached_image.page(params[:page]).per(5)
    @retweet_tweets = Tweet.where(id: @user.retweets.map(&:tweet_id)).with_attached_image.page(params[:page]).per(5)
    @comment_tweets = Tweet.where(id: @user.comments.map(&:tweet_id)).with_attached_image.page(params[:page]).per(5)
  end
end
