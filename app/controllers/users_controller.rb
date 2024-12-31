# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find_by(name: params[:name])
    @user_tweets = Tweet.where(user_id: @user.id).with_attached_image.page(params[:page]).per(5)

    # @user_tweets = @user_tweets
  end
end
