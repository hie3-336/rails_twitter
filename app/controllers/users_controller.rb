# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = current_user
    @tweets = Tweet.with_attached_image.page(params[:page]).per(5)

    @user_tweets = @tweets.where(user_id: @user.id)
  end
end
