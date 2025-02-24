# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :tweet, counter_cache: true
  belongs_to :user

  # 通知モデルとのポリモーフィック
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :user_id, uniqueness: { scope: :tweet_id }

  after_create_commit :create_notifications

  private
  def create_notifications
    Notification.create(notifiable: self, user: tweet.user)
  end
end
