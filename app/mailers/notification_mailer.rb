# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  default from: ENV['EMAIL_USER']

  def notice_mail(notification)
    @notification = notification

    mail(to: @notification.user.email, subject: 'Hietterからのお知らせ')
    # NotificationMailer.notice_mail.deliver_now
  end
end
