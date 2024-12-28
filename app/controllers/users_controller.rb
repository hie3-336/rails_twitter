# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find_by(name: params[:name])
    @tweets = Tweet.with_attached_image.page(params[:page]).per(5)

    @user_tweets = @tweets.where(user_id: @user.id)
  end
end
