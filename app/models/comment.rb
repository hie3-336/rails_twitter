# frozen_string_literal: true

class Comment < ApplicationRecord
  include Notifiable
  validates :content, length: { in: 1..140 }

  belongs_to :tweet, counter_cache: true
  belongs_to :user

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
