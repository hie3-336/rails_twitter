# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :tweet, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :comment_content

      t.timestamps
    end
    add_index :likes, [:user_id, :tweet_id], unique: true
  end
end
