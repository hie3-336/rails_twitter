# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = current_user
    @profile_user = User.find_by(name: params[:name])
    @user_tweets = Tweet.where(user_id: @profile_user.id).with_attached_image.page(params[:page]).per(5).includes(user: { avater_image_attachment: :blob })

    @like_tweets = Tweet.where(id: @profile_user.likes.map(&:tweet_id)).with_attached_image.page(params[:page]).per(5).includes(user: { avater_image_attachment: :blob })
    @retweet_tweets = Tweet.where(id: @profile_user.retweets.map(&:tweet_id)).with_attached_image.page(params[:page]).per(5).includes(user: { avater_image_attachment: :blob })
    @comment_tweets = Tweet.where(id: @profile_user.comments.map(&:tweet_id)).with_attached_image.page(params[:page]).per(5).includes(user: { avater_image_attachment: :blob })
  end
end
