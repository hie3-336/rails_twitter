class Directmessage < ApplicationRecord
  validates :message_content, presence: true

  belongs_to :send_user, class_name: 'User', foreign_key: 'send_user_id'
  belongs_to :receive_user, class_name: 'User', foreign_key: 'receive_user_id'
end
