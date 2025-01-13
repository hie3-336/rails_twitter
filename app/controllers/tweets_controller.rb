# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :set_user_and_tweets, only: %i[index create]

  def index
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = @user.id

    if @tweet.save
      redirect_to root_path(tab: 'recommend'), notice: 'ツイートを投稿しました！'
    else
      render :index, status: :unprocessable_entity
    end
  end

  def show
    @user = current_user
    @tweet = Tweet.find(params[:id])
  end

  private

  def tweet_params
    params.require(:tweet).permit(:tweet_text, :image)
  end

  def set_user_and_tweets
    @user = current_user
    @tweets = Tweet.with_attached_image.page(params[:page]).per(5).includes(user: { avater_image_attachment: :blob }).order(created_at: :desc)
    return if @user.blank?

    @following_tweets = @tweets.where(user_id: @user.followings.pluck(:id)).per(5).order(created_at: :desc)
  end
end
