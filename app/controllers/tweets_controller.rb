# frozen_string_literal: true

class TweetsController < ApplicationController
  def index
    @user = current_user
    @tweets = Tweet.with_attached_image.page(params[:page]).per(5)
    if @user.present?
      @following_tweets = @tweets.where(user_id: @user.followings.map(&:id))
    end
    
  end
end
