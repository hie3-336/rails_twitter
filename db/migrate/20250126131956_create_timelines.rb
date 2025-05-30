# frozen_string_literal: true

class CreateTimelines < ActiveRecord::Migration[7.0]
  def change
    create_table :timelines do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tweet, foreign_key: true
      t.references :retweet, foreign_key: true

      t.timestamps
    end
  end
end
