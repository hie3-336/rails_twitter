# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :content, length: { in: 1..140 }

  belongs_to :tweet, counter_cache: true
  belongs_to :user

  # 通知モデルとのポリモーフィック
  has_many :notifications, as: :notifiable, dependent: :destroy

  after_create_commit :create_notifications

  private

  def create_notifications
    return unless tweet.user != user

    notification = Notification.create(notifiable: self, user: tweet.user)
    notification.save!
    NotificationMailer.notice_mail(notification).deliver_now
  end
end
