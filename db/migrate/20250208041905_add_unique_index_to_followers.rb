# frozen_string_literal: true

class AddUniqueIndexToFollowers < ActiveRecord::Migration[7.0]
  def change
    add_index :followers, %i[follower_id followed_id], unique: true
  end
end
