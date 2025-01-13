# frozen_string_literal: true

class TweetsController < ApplicationController
  def index
    @user = current_user
    @tweet = Tweet.new
    @tweets = Tweet.with_attached_image.page(params[:page]).per(5).includes(user: { avater_image_attachment: :blob })
    return if @user.blank?

    @following_tweets = @tweets.where(user_id: @user.followings.pluck(:id)).per(5)
  end

  def create
    @user = current_user
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = @user.id
    @tweets = Tweet.with_attached_image.page(params[:page]).per(5).includes(user: { avater_image_attachment: :blob })
    return if @user.blank?

    @following_tweets = @tweets.where(user_id: @user.followings.pluck(:id)).per(5)
    if @tweet.save
      redirect_to root_path(tab: 'recommend'), notice: 'ツイートを投稿しました！'
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:tweet_text, :image)
  end
end
