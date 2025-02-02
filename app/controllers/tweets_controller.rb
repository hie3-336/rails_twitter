# frozen_string_literal: true

class TweetsController < ApplicationController
  def index
    @tweet = Tweet.new
    @timelines = Timeline.all.page(params[:page]).per(5).order(created_at: :desc).includes(:retweet)
    return if current_user.blank?

    @following_timelines = @timelines.where(user_id: current_user.followings.pluck(:id)).per(5).order(created_at: :desc)
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)

    if @tweet.save
      # ツイートが投稿されたら、timelineモデルにtweet_idも付与
      timeline = @tweet.build_timeline(user: @tweet.user)
      timeline.save!
      redirect_to root_path(tab: 'recommend'), notice: 'ツイートを投稿しました！'
    else
      redirect_to root_path(tab: 'recommend'), alert: @tweet.errors.full_messages
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
    @comments = @tweet.comments.includes(user: [avater_image_attachment: :blob])
  end

  def post_comment
    @tweet = Tweet.find(params[:id])
    @comment = @tweet.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to tweet_path(id: params[:id]), notice: 'コメントを投稿しました！'
    else
      redirect_to tweet_path(id: params[:id]), alert: @comment.errors.full_messages
    end
  end

  def like_tweet
    @like = current_user.likes.find_by(tweet_id: params[:tweet_id])
    if @like.present?
      redirect_to request.referer if @like.destroy
    else
      @like = current_user.likes.create(tweet_id: params[:tweet_id])
      redirect_to request.referer if @like.save
    end
  end

  def retweet_tweet
    @retweet = current_user.retweets.find_by(tweet_id: params[:tweet_id])
    if @retweet.present?
      # timelineのretweetも関連付けにより削除される
      redirect_to request.referer if @retweet.destroy
    else
      @retweet = current_user.retweets.create(tweet_id: params[:tweet_id])
      @retweet.save
      # リツイートされたら、timelineモデルにretweet_idも付与
      timeline = @retweet.build_timeline(user: @retweet.user)
      redirect_to request.referer if timeline.save
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:tweet_text, :image)
  end

  def comment_params
    params.require(:comment).permit(:comment_content)
  end
end
