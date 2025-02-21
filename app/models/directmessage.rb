# frozen_string_literal: true

class Directmessage < ApplicationRecord
  validates :message_content, presence: true

  belongs_to :send_user, class_name: 'User'
  belongs_to :receive_user, class_name: 'User'
end
