# frozen_string_literal: true

class Follower < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  # 通知モデルとのポリモーフィック
  has_many :notifications, as: :notifiable, dependent: :destroy

  after_create_commit :create_notifications

  private
  def create_notifications
    notification = Notification.create(notifiable: self, user: followed)
    notification.save!
    NotificationMailer.notice_mail(notification).deliver_now
  end

end
