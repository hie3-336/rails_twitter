# frozen_string_literal: true

class UsersController < ApplicationController
  include FetchTweets
  before_action :set_user
  before_action :authenticate_user!, only: %i[edit update]

  def show
    @user_timelines = @profile_user.timelines
                                   .page(params[:page]).per(5)
                                   .order(created_at: :desc)
                                   .includes(:retweet)

    @liked_tweets = fetch_tweets(@profile_user.likes.pluck(:tweet_id))
    @retweeted_tweets = fetch_tweets(@profile_user.retweets.pluck(:tweet_id))
    @commented_tweets = fetch_tweets(@profile_user.comments.pluck(:tweet_id))
  end

  def edit
    redirect_to user_path(current_user.name, tab: 'tweet'), alert: 'こちらのページにはアクセスできません' if current_user != @profile_user
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user.name, tab: 'tweet'), notice: 'プロフィールを更新しました！'
    else
      redirect_to user_path(current_user.name, tab: 'tweet'), alert: current_user.errors.full_messages
    end
  end

  def follow_user
    follower = Follower.find_by(follower_id: current_user.id, followed_id: params[:user_id])
    if follower.present?
      redirect_to request.referer if follower.destroy
    else
      follower = Follower.create(follower_id: current_user.id, followed_id: params[:user_id])
      redirect_to request.referer if follower.save
    end
  end

  private

  def set_user
    @profile_user = User.find_by(name: params[:name])
  end

  def user_params
    params.require(:user).permit(:name, :phone_number, :birthday, :introduction, :place, :website, :profile_image, :avatar_image)
  end
end
