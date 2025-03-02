# frozen_string_literal: true

class Retweet < ApplicationRecord
  belongs_to :tweet, counter_cache: true
  belongs_to :user

  has_one :timeline, dependent: :destroy

  # 通知モデルとのポリモーフィック
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :user_id, uniqueness: { scope: :tweet_id }

  after_create_commit :create_notifications

  private
  def create_notifications
    if tweet.user != user
      notification = Notification.create(notifiable: self, user: tweet.user)
      notification.save!
      NotificationMailer.notice_mail(notification).deliver_now
    end
  end
end
