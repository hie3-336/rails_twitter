# frozen_string_literal: true

class TweetsController < ApplicationController
  def index
    @user = current_user
    @tweets = Tweet.with_attached_image.page(params[:page]).per(5).includes(user: { avater_image_attachment: :blob })
    return if @user.blank?

    @following_tweets = @tweets.where(user_id: @user.followings.map(&:id)).page(params[:page]).per(5).includes(user: { avater_image_attachment: :blob })
  end
end
