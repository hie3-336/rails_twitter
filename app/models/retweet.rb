# frozen_string_literal: true

class Retweet < ApplicationRecord
  include Notifiable
  belongs_to :tweet, counter_cache: true
  belongs_to :user

  has_one :timeline, dependent: :destroy

  validates :user_id, uniqueness: { scope: :tweet_id }

  private

  # 自分自身へのアクションかどうかの判定
  def check_create_notification
    tweet.user == user
  end

  # 通知受信者の指定
  def notification_recipient
    tweet.user
  end
end
