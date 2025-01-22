# frozen_string_literal: true

class AddColumnToTweet < ActiveRecord::Migration[7.0]
  def change
    change_table :tweets, bulk: true do |t|
      t.integer :likes_count, default: 0
      t.integer :retweets_count, default: 0
      t.integer :comments_count, default: 0
    end
  end
end
