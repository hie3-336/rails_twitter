# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.references :notifiable, null: false, polymorphic: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
