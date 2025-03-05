# frozen_string_literal: true

class Follower < ApplicationRecord
  include Notifiable
  
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  private

  # 自分自身へのアクションかどうかの判定(セルフフォローはできない為ここではnil)
  def check_create_notification
    nil
  end

  # 通知受信者の指定
  def notification_recipient
    followed
  end
end
