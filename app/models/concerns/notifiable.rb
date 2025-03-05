# frozen_string_literal: true

module Notifiable
  extend ActiveSupport::Concern

  included do
    # 通知モデルとのポリモーフィック
    has_many :notifications, as: :notifiable, dependent: :destroy

    after_create_commit :create_notifications
  end

  private

  def create_notifications
    return if check_create_notification

    notification = Notification.create(notifiable: self, user: notification_recipient)
    notification.save!
    NotificationMailer.notice_mail(notification).deliver_now
  end
end
