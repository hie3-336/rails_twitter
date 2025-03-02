# frozen_string_literal: true

class RenameTweetTextColumnToTweets < ActiveRecord::Migration[7.0]
  def change
    rename_column :tweets, :tweet_text, :content
  end
end
