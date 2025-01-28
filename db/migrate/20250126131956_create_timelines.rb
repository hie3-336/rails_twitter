class CreateTimelines < ActiveRecord::Migration[7.0]
  def change
    create_table :timelines do |t|
      t.integer :user_id
      t.integer :tweet_id
      t.integer :retweet_id

      t.timestamps
    end
  end
end
