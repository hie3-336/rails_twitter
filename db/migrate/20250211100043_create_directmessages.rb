# frozen_string_literal: true

class CreateDirectmessages < ActiveRecord::Migration[7.0]
  def change
    create_table :directmessages do |t|
      t.integer :send_user_id
      t.integer :receive_user_id
      t.string :message_content

      t.timestamps
    end
  end
end
