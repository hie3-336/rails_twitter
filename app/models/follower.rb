# frozen_string_literal: true

class Follower < ApplicationRecord
  include Notifiable

  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  validate :cannot_follow_self

  private

  # 自己フォロー防止のバリデーション
  def cannot_follow_self
    errors.add(:follower_id, '自分自身をフォローすることはできません') if follower_id == followed_id
  end

  # 自分自身へのアクションかどうかの判定(セルフフォローはできない為ここではnil)
  def check_create_notification
    nil
  end

  # 通知受信者の指定
  def notification_recipient
    followed
  end
end
