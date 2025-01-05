# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = current_user
    @profile_user = User.find_by(name: params[:name])
    @user_tweets = Tweet.where(user_id: @profile_user.id)
                        .with_attached_image.page(params[:page]).per(5)
                        .includes(user: { avater_image_attachment: :blob })

    @like_tweets = fetch_tweets(@profile_user.likes.map(&:tweet_id))
    @retweet_tweets = fetch_tweets(@profile_user.retweets.map(&:tweet_id))
    @comment_tweets = fetch_tweets(@profile_user.comments.map(&:tweet_id))
  end

  private

  # 各種ツイート取得処理
  def fetch_tweets(tweet_ids)
    Tweet.where(id: tweet_ids)
         .with_attached_image.page(params[:page]).per(5)
         .includes(user: { avater_image_attachment: :blob })
  end
end
