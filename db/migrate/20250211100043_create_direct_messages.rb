# frozen_string_literal: true

class CreateDirectMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :direct_messages do |t|
      t.integer :send_user_id
      t.integer :receive_user_id
      t.string :content

      t.timestamps
    end
  end
end
