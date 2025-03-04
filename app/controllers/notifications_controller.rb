# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.order(created_at: :desc).includes(notifiable: [:tweet, :follower, {
      user: [avater_image_attachment: :blob]
    }])
  end
end
