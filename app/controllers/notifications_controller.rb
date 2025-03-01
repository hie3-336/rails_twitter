class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notification.where(user_id: current_user.id).order(created_at: :desc).includes(notifiable: [:tweet, user: [avater_image_attachment: :blob]])
  end
end
