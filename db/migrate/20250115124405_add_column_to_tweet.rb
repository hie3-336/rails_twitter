class AddColumnToTweet < ActiveRecord::Migration[7.0]
  def change
    add_column :tweets, :likes_count, :integer, default: 0
    add_column :tweets, :retweets_count, :integer, default: 0
  end
end
