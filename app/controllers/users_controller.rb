# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!, only: %i[edit update]

  def show
    @user_tweets = @profile_user.tweets.with_attached_image
                                .page(params[:page]).per(5)
                                .includes(user: { avater_image_attachment: :blob })
                                .order(created_at: :desc)

    @like_tweets = fetch_tweets(@profile_user.likes.pluck(:tweet_id))
    @retweet_tweets = fetch_tweets(@profile_user.retweets.pluck(:tweet_id))
    @comment_tweets = fetch_tweets(@profile_user.comments.pluck(:tweet_id))
  end

  def edit
    redirect_to user_path(@user.name, tab: 'tweet'), alert: 'こちらのページにはアクセスできません' if @user != @profile_user
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.name, tab: 'tweet'), notice: 'プロフィールを更新しました！'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
    @profile_user = User.find_by(name: params[:name])
  end

  # 各種ツイート取得処理
  def fetch_tweets(tweet_ids)
    Tweet.where(id: tweet_ids)
         .with_attached_image.page(params[:page]).per(5)
         .includes(user: { avater_image_attachment: :blob })
         .order(created_at: :desc)
  end

  def user_params
    params.require(:user).permit(:name, :phone_number, :birthday, :introduction, :place, :website, :profile_image, :avatar_image)
  end
end
