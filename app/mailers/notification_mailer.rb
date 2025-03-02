class NotificationMailer < ApplicationMailer
  def notice
    @greeting = "Hi!"

    mail to: "tomohiko336@gmail.com"
    # NotificationMailer.notice.deliver_now
  end
end
